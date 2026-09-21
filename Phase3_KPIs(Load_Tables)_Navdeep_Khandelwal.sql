CREATE DATABASE streamflix;
USE streamflix;

CREATE TABLE subscribers (
    subscriber_id      VARCHAR(12)  PRIMARY KEY,
    signup_date        DATE,
    country            VARCHAR(40),
    region             VARCHAR(40),
    age                INTEGER,
    gender             VARCHAR(20),
    plan_type          VARCHAR(30),     -- Basic with Ads / Standard / Premium
    monthly_price_usd  DECIMAL(6,2),
    household_size     INTEGER,
    primary_device     VARCHAR(30),
    payment_method     VARCHAR(30),
    tenure_months      INTEGER,
    is_active          VARCHAR(10),
    churn_date         DATE             -- NULL for active subscribers
);

CREATE TABLE titles (
    title_id            VARCHAR(12)  PRIMARY KEY,
    title_name          VARCHAR(200),
    type                VARCHAR(10),    -- Movie / TV Show
    primary_genre       VARCHAR(40),
    country             VARCHAR(40),
    language            VARCHAR(40),
    release_year        INTEGER,
    date_added          DATE,
    maturity_rating     VARCHAR(10),
    seasons             INTEGER,        -- 0 for movies
    content_duration_min INTEGER,
    is_original         VARCHAR(40),
    license_type        VARCHAR(30),    -- Original / Exclusive License / Non-Exclusive License
    director            VARCHAR(80),
    cast                VARCHAR(300),
    quality_score       DECIMAL(5,2),   -- 0-100
    popularity_score    DECIMAL(5,4),   -- 0-1
    license_cost_usd    DECIMAL(14,2),
    license_expiry      DATE,           -- NULL for Originals
    total_watch_hours   DECIMAL(14,2),
    total_plays         INTEGER
);

CREATE TABLE watch_history (
    watch_id            BIGINT       PRIMARY KEY,
    subscriber_id       VARCHAR(12)  REFERENCES subscribers(subscriber_id),
    title_id            VARCHAR(12)  REFERENCES titles(title_id),
    watch_date          DATE,
    device              VARCHAR(30),
    region              VARCHAR(40),
    content_duration_min INTEGER,
    watch_duration_min  DECIMAL(10,2),
    completion_pct      DECIMAL(5,2),   -- 0-100
    completed           BOOLEAN
);

CREATE TABLE ratings (
    rating_id           BIGINT       PRIMARY KEY,
    subscriber_id       VARCHAR(12)  REFERENCES subscribers(subscriber_id),
    title_id            VARCHAR(12)  REFERENCES titles(title_id),
    rating              INTEGER,        -- 1-5
    rating_date         DATE
);

CREATE TABLE reviews (
    review_id           BIGINT       PRIMARY KEY,
    subscriber_id       VARCHAR(12)  REFERENCES subscribers(subscriber_id),
    title_id            VARCHAR(12)  REFERENCES titles(title_id),
    review_text         VARCHAR(500),
    sentiment           VARCHAR(10),    -- Positive / Neutral / Negative
    helpful_votes       INTEGER,
    review_date         DATE
);

CREATE TABLE watchlist (
    watchlist_id        BIGINT       PRIMARY KEY,
    subscriber_id       VARCHAR(12)  REFERENCES subscribers(subscriber_id),
    title_id            VARCHAR(12)  REFERENCES titles(title_id),
    added_date          DATE,
    watched             VARCHAR(10)
);
UPDATE watchlist
SET watched = REPLACE(watched, CHAR(13), '');
#The CHAR(13) represented by ASCII code 13 and Find the carriage return character inside watched column and replace it with nothing.

LOAD DATA LOCAL INFILE 'C:/Users/mrnk1/Desktop/StreamFlix Project/subscribers.csv'
INTO TABLE subscribers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/mrnk1/Desktop/StreamFlix Project/titles.csv'
INTO TABLE titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/mrnk1/Desktop/StreamFlix Project/watch_history.csv'
INTO TABLE watch_history
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/mrnk1/Desktop/StreamFlix Project/ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/mrnk1/Desktop/StreamFlix Project/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/mrnk1/Desktop/StreamFlix Project/watchlist.csv'
INTO TABLE watchlist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM subscribers;
SELECT COUNT(*) FROM titles;
SELECT COUNT(*) FROM watch_history;
SELECT COUNT(*) FROM ratings;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM watchlist;