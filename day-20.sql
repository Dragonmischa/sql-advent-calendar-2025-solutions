-- SQL Advent Calendar - Day 20
-- Title: Hot Cocoa Break Logs
-- Difficulty: medium
--
-- Question:
-- Jack Frost wants to review all the cocoa breaks he actually took — including the cocoa type and the location he drank it in. How would you combine the necessary tables to show each logged break with its matching cocoa details and location?
--
-- Jack Frost wants to review all the cocoa breaks he actually took — including the cocoa type and the location he drank it in. How would you combine the necessary tables to show each logged break with its matching cocoa details and location?
--

-- Table Schema:
-- Table: cocoa_logs
--   log_id: INT
--   break_id: INT
--   cocoa_id: INT
--
-- Table: break_schedule
--   break_id: INT
--   location_id: INT
--
-- Table: cocoa_types
--   cocoa_id: INT
--   cocoa_name: VARCHAR
--
-- Table: locations
--   location_id: INT
--   location_name: VARCHAR
--

-- My Solution:

SELECT
  c_t.cocoa_id,
  c_t.cocoa_name,
  b.break_id,
  l.location_id,
  l.location_name
FROM cocoa_types AS c_t
JOIN cocoa_logs AS c_l ON c_t.cocoa_id = c_l.cocoa_id
JOIN break_schedule AS b ON c_l.break_id = b.break_id 
JOIN locations AS l ON b.location_id = l.location_id
ORDER BY c_t.cocoa_id ASC
