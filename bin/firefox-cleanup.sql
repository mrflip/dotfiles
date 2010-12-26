
--
-- run with
--
--   cd ~/Library/Application Support/Firefox/Profiles/*
--   cp places.sqlite /tmp/places-`basename "$PWD"`-`date "+%Y%m%d%H%M%S"`.sqlite
--   cat firefox-cleanup.sql | sqlite places.sqlite | cut -c 1-250
--

.mode    tabs
.headers on


-- -- ===========================================================================
-- --
-- -- Inspect bookmarks
-- -- 

-- --
-- -- Show the top-visited sites
-- --
-- select pl.id
--   , MIN(pl.visit_count, 15)     AS v_bin
--   , pl.visit_count              AS v_count
--   , ROUND(julianday('now') - ( pl.last_visit_date / (86400 * 1000000)) - 2440587.5) AS days
--   , SUBSTR(pl.rev_host || '               ', 1, 23)
--   , SUBSTR(pl.title    || '                                                     ', 1, 63)
--   , SUBSTR(pl.url, 1, 100)
--   FROM          moz_places pl
--   WHERE         visit_count > 15
--   ORDER BY      visit_count ASC
--   LIMIT         100
--   ;
-- 
-- -- 
-- -- Show histogram of site visits
-- --
-- select
--   MIN(visit_count, 15) AS v_bin, count(hi.place_id) AS nvisits, COUNT(DISTINCT pl.id) AS nplaces
--   FROM          moz_places        pl
--   LEFT JOIN     moz_historyvisits hi ON (pl.id = hi.place_id)
--   GROUP BY      v_bin
--   ORDER BY      visit_count ASC
--   ;

--
-- ===========================================================================
--
-- Select bookmarks from moz_places for deletion
--
--

CREATE TEMPORARY TABLE places_old (
  id                    INTEGER PRIMARY KEY,         
  url                   LONGVARCHAR,                 
  title                 LONGVARCHAR,                 
  rev_host              LONGVARCHAR,                 
  visit_count           INTEGER DEFAULT 0,           
  hidden                INTEGER DEFAULT 0 NOT NULL,  
  typed                 INTEGER DEFAULT 0 NOT NULL,  
  favicon_id            INTEGER,                     
  frecency              INTEGER DEFAULT -1 NOT NULL, 
  last_visit_date       INTEGER                      
  )
  ;

-- 
-- Bookmarks that will be deleted:
-- * visited two or fewer times
-- * not bookmarked or typed in
-- * older than thirty days
--
INSERT OR REPLACE INTO places_old
       (    id,    url,    title,    rev_host,    visit_count,    hidden,    typed,    favicon_id,    frecency,    last_visit_date )
  SELECT pl.id,pl.url,  pl.title, pl.rev_host, pl.visit_count, pl.hidden, pl.typed, pl.favicon_id, pl.frecency, pl.last_visit_date 
  FROM          moz_places       pl
  LEFT JOIN     moz_bookmarks    bo   ON (pl.id = bo.fk)
  LEFT JOIN     moz_inputhistory inhi ON (pl.id = inhi.place_id)
  WHERE
                (visit_count <= 1)
    AND         bo.fk           IS NULL
    AND         inhi.place_id   IS NULL
    AND         ROUND(julianday('now') - ( last_visit_date / (86400000000)) - 2440587.5) > 30
  ;

-- remove bookmarks on ec2 ephemeral hosts
INSERT OR REPLACE INTO places_old
       (    id,    url,    title,    rev_host,    visit_count,    hidden,    typed,    favicon_id,    frecency,    last_visit_date )
  SELECT pl.id,pl.url,  pl.title, pl.rev_host, pl.visit_count, pl.hidden, pl.typed, pl.favicon_id, pl.frecency, pl.last_visit_date 
  FROM          moz_places       pl
  WHERE         pl.rev_host LIKE "moc.swanozama%"
  ;

-- dump the table
SELECT plo.id
  , MIN(visit_count, 15)     AS v_bin
  , visit_count              AS v_count
  , ROUND(julianday('now') - ( last_visit_date / (86400 * 1000000)) - 2440587.5) AS days
  , SUBSTR(plo.rev_host || '               ', 1, 23)
  , SUBSTR(plo.title    || '                                                         ', 1, 63)
  , SUBSTR(plo.url, 1, 100)
  FROM          places_old plo
  ORDER BY      visit_count ASC
  ;

--
-- ===========================================================================
--
-- Delete corresponding bookmarks in moz_historyvisits
--
--

-- DELETE
--   FROM          moz_historyvisits 
--   WHERE         (ROUND(julianday('now') - ( visit_date / (86400 * 1000000)) - 2440587.5)) > 1200
--   ;
-- 
-- DELETE
--   FROM          moz_historyvisits 
--   WHERE         place_id IN (SELECT id FROM places_old)
--   ;
-- 
-- DELETE
--   FROM          moz_places 
--   WHERE         id IN (SELECT id FROM places_old)
--   ;

vacuum;
