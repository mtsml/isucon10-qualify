DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_height_range SMALLINT AS (
        CASE 
            WHEN door_height < 80 THEN 1
            WHEN door_height < 110 THEN 2
            WHEN door_height < 150 THEN 3
            ELSE 4
        END
    ) NOT NULL,
    door_width  INTEGER             NOT NULL,
    door_width_range SMALLINT AS (
        CASE 
            WHEN door_width < 80 THEN 1
            WHEN door_width < 110 THEN 2
            WHEN door_width < 150 THEN 3
            ELSE 4
        END
    ) NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    popularity_desc INTEGER AS (-popularity) NOT NULL,
    point POINT AS (POINT(latitude, longitude)) STORED NOT NULL
);

CREATE INDEX idx_estate_rent_id ON isuumo.estate(rent, id);
CREATE INDEX idx_estate_popularity ON isuumo.estate(popularity_desc, id);
CREATE INDEX idx_estate_door_height ON isuumo.estate(door_height, rent);
CREATE INDEX idx_estate_door_width ON isuumo.estate(door_width, rent);
CREATE INDEX idx_estate_door_height_weight ON isuumo.estate(door_height, door_width, rent);
ALTER TABLE isuumo.estate ADD SPATIAL INDEX estate_point_idx(point);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    height_range SMALLINT AS (
        CASE 
            WHEN height < 80 THEN 1
            WHEN height < 110 THEN 2
            WHEN height < 150 THEN 3
            ELSE 4
        END
    ) NOT NULL,
    width       INTEGER         NOT NULL,
    width_range SMALLINT AS (
        CASE 
            WHEN width < 80 THEN 1
            WHEN width < 110 THEN 2
            WHEN width < 150 THEN 3
            ELSE 4
        END
    ) NOT NULL,
    depth       INTEGER         NOT NULL,
    depth_range SMALLINT AS (
        CASE 
            WHEN depth < 80 THEN 1
            WHEN depth < 110 THEN 2
            WHEN depth < 150 THEN 3
            ELSE 4
        END
    ) NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL,
    popularity_desc INTEGER AS (-popularity) NOT NULL
);

CREATE INDEX idx_chair_price ON isuumo.chair(price);
CREATE INDEX idx_chair_popularity ON isuumo.chair(popularity_desc, price);
CREATE INDEX idx_chair_height ON isuumo.chair(height);
CREATE INDEX idx_chair_width ON isuumo.chair(width);
CREATE INDEX idx_chair_depth ON isuumo.chair(depth);
