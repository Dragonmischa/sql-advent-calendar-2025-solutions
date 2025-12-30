-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH message_per_day AS (
  SELECT
    sender_id,
    COUNT(message_id) AS count_messages,
    DATE(sent_at) AS sent_at_day
  FROM npn_messages
  GROUP BY DATE(sent_at), sender_id
  ORDER BY count_messages DESC, sender_id ASC
),

best_one AS (
  SELECT
    m.sender_id,
    u.user_name,
    m.sent_at_day,
    RANK () OVER (PARTITION BY m.sent_at_day ORDER BY m.count_messages DESC, m.sender_id ASC) AS r
  FROM message_per_day AS m
  LEFT JOIN npn_users AS u ON m.sender_id = u.user_id
)

SELECT
  b.sender_id,
  b.user_name
FROM best_one AS b
WHERE b.r = 1
