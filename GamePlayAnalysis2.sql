SELECT a.player_id, a.device_id 
FROM (
    SELECT b.player_id, b.device_id, b.event_date, 
           RANK() OVER(PARTITION BY b.player_id ORDER BY b.event_date) AS 'rnk' 
    FROM Activity b
) a 
WHERE a.rnk = 1;
