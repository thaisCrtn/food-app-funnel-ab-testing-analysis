-- Total number of events
SELECT COUNT(*) AS total_events
FROM food_app_events;

-- Total number of unique users

SELECT COUNT(DISTINCT device_id_hash)
FROM food_app_events;

-- Average User per Event
SELECT 
    COUNT(*):: NUMERIC / COUNT(DISTINCT device_id_hash) AS avg_events_per_user
FROM food_app_events;

-- What is the period covered by the data?
SELECT 
    MAX(date) AS max_date,
    MIN(date) AS min_date
FROM food_app_events
GROUP BY date
ORDER BY date ASC;

-- Frequency of events per day.

SELECT 
    date,
    COUNT(*) AS total_events
FROM food_app_events
GROUP BY date
ORDER BY date ASC;

-- How many times did each event occur?
SELECT 
    event_name,
    COUNT(*) AS total_events
FROM food_app_events
GROUP BY event_name
ORDER BY total_events DESC;

-- How many unique users performed each event at least once?
SELECT 
    event_name,
    COUNT(DISTINCT device_id_hash) AS unique_users
FROM food_app_events
GROUP BY event_name
ORDER BY unique_users DESC;

-- Of all users, what percentage performed each event at least once?
SELECT 
    event_name,
    COUNT(DISTINCT device_id_hash) AS unique_users,
    ROUND(
        COUNT(DISTINCT device_id_hash) * 100.0 /
        (SELECT COUNT(DISTINCT device_id_hash)
        FROM food_app_events), 2
    ) AS user_percentage
FROM food_app_events
GROUP BY event_name
ORDER BY unique_users DESC;

-- How many unique users performed this event at least once?
SELECT
    COUNT(DISTINCT CASE 
        WHEN event_name = 'MainScreenAppear' THEN device_id_hash 
    END) AS main_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'OffersScreenAppear' THEN device_id_hash
    END) AS offers_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'CartScreenAppear' THEN device_id_hash
    END) AS cart_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'PaymentScreenSuccessful' THEN device_id_hash
    END) AS payment_users
FROM food_app_events;

-- Conversion rates between stages of the funnel / 
-- What percentage of users who reached the first event made it to the payment stage?


WITH funnel AS (
    SELECT
    COUNT(DISTINCT CASE 
        WHEN event_name = 'MainScreenAppear' THEN device_id_hash 
    END) AS main_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'OffersScreenAppear' THEN device_id_hash
    END) AS offers_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'CartScreenAppear' THEN device_id_hash
    END) AS cart_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'PaymentScreenSuccessful' THEN device_id_hash
    END) AS payment_users
FROM food_app_events
)

SELECT 
    main_users,
    offers_users,
    cart_users,
    payment_users,

    ROUND(offers_users * 100.0 / main_users, 2) AS main_to_offers,
    ROUND(cart_users * 100.0 / offers_users, 2) AS cart_to_offers,
    ROUND(payment_users * 100.0 / cart_users, 2) AS payment_to_cart,
    ROUND(payment_users * 100.0 / main_users, 2) AS overall_conversion
FROM funnel;

-- Count by group
SELECT
    exp_id,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'MainScreenAppear' THEN device_id_hash 
    END) AS main_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'OffersScreenAppear' THEN device_id_hash
    END) AS offers_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'CartScreenAppear' THEN device_id_hash
    END) AS cart_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'PaymentScreenSuccessful' THEN device_id_hash
    END) AS payment_users
FROM food_app_events
GROUP BY exp_id
ORDER BY exp_id;

-- funnel conversion by group

WITH funnel_by_group AS (
    SELECT
    exp_id,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'MainScreenAppear' THEN device_id_hash 
    END) AS main_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'OffersScreenAppear' THEN device_id_hash
    END) AS offers_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'CartScreenAppear' THEN device_id_hash
    END) AS cart_users,
    COUNT(DISTINCT CASE 
        WHEN event_name = 'PaymentScreenSuccessful' THEN device_id_hash
    END) AS payment_users
FROM food_app_events
GROUP BY exp_id
)

SELECT 
    exp_id,
    ROUND(offers_users * 100.0 / main_users, 2) AS main_to_offers,
    ROUND(cart_users * 100.0 / offers_users, 2) AS offers_to_cart,
    ROUND(payment_users * 100.0 / cart_users, 2) AS cart_to_payment,
    ROUND(payment_users * 100.0 / main_users, 2) AS overall_conversion
FROM funnel_by_group
ORDER BY exp_id;

--The experimental groups in a table ready for analysis/dashboard
SELECT 
    exp_id,
    COUNT(DISTINCT device_id_hash) AS unique_users,
    COUNT(*) AS total_events,
    ROUND(
        COUNT(*)::NUMERIC / COUNT(DISTINCT device_id_hash), 2
    ) AS avg_events_per_user
FROM food_app_events
GROUP BY exp_id
ORDER BY exp_id;