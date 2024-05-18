WITH
  today AS (
    SELECT
      *
    FROM
      jrsarrat.user_devices_cumulated
    WHERE
      DATE = DATE('2023-01-07')
  )
SELECT
  user_id,
  SUM(
    CASE
      WHEN CONTAINS(dates_active, sequence_date) THEN POW(2, 32 - DATE_DIFF('day', sequence_date, DATE))
      ELSE 0
    END
  )
FROM
  today
  CROSS JOIN UNNEST (SEQUENCE(DATE('2023-01-01'), DATE('2023-01-07'))) AS t (sequence_date)
GROUP BY
  user_id
