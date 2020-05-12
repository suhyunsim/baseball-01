DROP TABLE IF EXISTS hitter, pitcher, logo, user, matches, team, record, halfInning, log;

CREATE TABLE team
(
    team_id   int auto_increment primary key,
    team_name varchar(64),
    team_type varchar(64),
    user_name varchar(64) DEFAULT 'none',
    logo_id int REFERENCES logo(logo_id) ON UPDATE CASCADE,
    match_id int REFERENCES matches(match_id) ON UPDATE CASCADE,
    pitcher_id int REFERENCES pitcher(pitcher_id) ON UPDATE CASCADE
);

CREATE TABLE logo
(
    logo_id int auto_increment primary key,
    url varchar(255)
);

CREATE TABLE user
(
    user_id int auto_increment primary key,
    name varchar(64)
);

CREATE TABLE matches
(
    match_id int auto_increment primary key,
    home_team varchar (64),
    away_team varchar (64)
);

CREATE TABLE pitcher
(
    pitcher_id      int auto_increment primary key,
    pitcher_name    varchar(64)
);

CREATE TABLE hitter
(
    hitter_id      int auto_increment primary key,
    hitter_name    varchar(64),
    hitter_number int,
--     accumulatedPA int,
--     accumulatedHit int,
--     accumulatedOut int,
--     accumulatedAverage int,
    average float,
    team_id int REFERENCES team (team_id) ON UPDATE CASCADE
);

create table record (
                        record_id int primary key auto_increment,
                        hitter_name varchar (255),
                        hitter_number int,
                        strike_count int,
                        ball_count int,
                        out_count int,
                        hit_count int,
                        average int,
                        plate_appearance int,
                        available bit(1),
                        team_id int references team(team_id),
                        hitter_id int references hitter(hitter_id)
);
create table halfInning (
                        inning_id int primary key auto_increment,
                        round varchar(255),
                        hit_score int,
                        pitcher_name varchar (255),
                        number_of_pitches int,
                        outSum int,
                        status varchar(255)
);
create table log (
                     log_id int primary key auto_increment,
                     hitter_name varchar(255),
                     hitter_number int,
                     plate_appearance int,
                     action_result varchar (255),
                     strike_count int,
                     ball_count int,
                     out_count int,
                     hit_count int,
                     available bit(1),
                     inning_id int references halfInning(inning_id)
);
