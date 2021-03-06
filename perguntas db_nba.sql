
-- PRIMARY AND FOREIGN KEYS
ALTER TABLE games ADD PRIMARY KEY (GAME_ID);
ALTER TABLE teams ADD PRIMARY KEY (TEAM_ID);
ALTER TABLE games_details ADD FOREIGN KEY(GAME_ID) REFERENCES games(GAME_ID);
ALTER TABLE games_details ADD FOREIGN KEY(TEAM_ID) REFERENCES teams(TEAM_ID);
ALTER TABLE games ADD FOREIGN KEY(HOME_TEAM_ID) REFERENCES teams(TEAM_ID);
ALTER TABLE games ADD FOREIGN KEY(VISITOR_TEAM_ID) REFERENCES teams(TEAM_ID);



-- Top 10  de jogadores que possui as maiores médias de arremessos da década

select games_details.PLAYER_NAME, games_details.TEAM_CITY, round(avg(games_details.FGM + games_details.FGA + games_details.FG_PCT + games_details.FG3M + games_details.FG3A 
+ games_details.FTM + games_details.FTA),2) as média_de_arremessos,games.SEASON,
 CASE
  WHEN games.SEASON = '2010' THEN '2010-2011'
  WHEN games.SEASON = '2011' THEN '2011-2012'
  WHEN games.SEASON = '2012' THEN '2012-2013'
  WHEN games.SEASON = '2013' THEN '2013-2014'
  WHEN games.SEASON = '2014' THEN '2014-2015'
  WHEN games.SEASON = '2015' THEN '2015-2016'
  WHEN games.SEASON = '2016' THEN '2016-2017'
  WHEN games.SEASON = '2017' THEN '2017-2018'  
  WHEN games.SEASON = '2018' THEN '2018-2019'
  WHEN games.SEASON = '2019' THEN '2019-2020'
  WHEN games.SEASON = '2020' THEN '2020-2021'
  END as Temporada
from games_details
 inner join games on games_details.game_id = games.game_id
 where games.SEASON between '2010' and '2019' 
group by games_details.PLAYER_NAME,games_details.TEAM_CITY,games.SEASON having média_de_arremessos > 50 order by média_de_arremessos desc  limit 10 ;

-- Top 10 jogadores que mais permaneceram na quadra na década
select  games_details.PLAYER_NAME, games_details.TEAM_CITY, sum(games_details.min ) as minuntos_jogados,games.SEASON,
 CASE
  WHEN games.SEASON = '2010' THEN '2010-2011'
  WHEN games.SEASON = '2011' THEN '2011-2012'
  WHEN games.SEASON = '2012' THEN '2012-2013'
  WHEN games.SEASON = '2013' THEN '2013-2014'
  WHEN games.SEASON = '2014' THEN '2014-2015'
  WHEN games.SEASON = '2015' THEN '2015-2016'
  WHEN games.SEASON = '2016' THEN '2016-2017'
  WHEN games.SEASON = '2017' THEN '2017-2018'
  WHEN games.SEASON = '2018' THEN '2018-2019'
  WHEN games.SEASON = '2019' THEN '2019-2020'
  WHEN games.SEASON = '2020' THEN '2020-2021'
  END as Temporada 
from games_details
inner join games on games_details.game_id = games.game_id
where games.SEASON between '2010' and '2019' 
group by games_details.PLAYER_NAME, games_details.TEAM_CITY,games.SEASON  order by minuntos_jogados desc limit 10;


-- Top 10 dos times que mais venceram em casa da década 
select games.TEAM_ID_home as time_de_casa,games_details.TEAM_CITY, sum(games.home_team_wins) as partidas_ganhadas_em_casa,games.SEASON,
CASE
  WHEN games.SEASON = '2010' THEN '2010-2011'
WHEN games.SEASON = '2012' THEN '2012-2013'
  WHEN games.SEASON = '2013' THEN '2013-2014'
  WHEN games.SEASON = '2014' THEN '2014-2015'
  WHEN games.SEASON = '2015' THEN '2015-2016'
  WHEN games.SEASON = '2016' THEN '2016-2017'
  WHEN games.SEASON = '2017' THEN '2017-2018'
  WHEN games.SEASON = '2018' THEN '2018-2019'
  WHEN games.SEASON = '2019' THEN '2019-2020'
  WHEN games.SEASON = '2020' THEN '2020-2021'
  END as Temporada 
from games
inner join games_details on games_details.game_id = games.game_id
where
	games.season between '2010' and '2019' 
group by time_de_casa,games_details.TEAM_CITY,games.SEASON having partidas_ganhadas_em_casa > 250  order by partidas_ganhadas_em_casa desc limit 10;

-- Top 10 Cestinhas(Maiores Pontuações) na década
 SELECT 
	games_details.player_name as nome_jogador ,
	concat(games_details.TEAM_CITY,' ', teams.nickname) as time,
	sum(PTS) as Pontos,
	count(games_details.game_id) as jogos,
	CASE
  WHEN games.SEASON = '2010' THEN '2010-2011'
WHEN games.SEASON = '2012' THEN '2012-2013'
  WHEN games.SEASON = '2013' THEN '2013-2014'
  WHEN games.SEASON = '2014' THEN '2014-2015'
  WHEN games.SEASON = '2015' THEN '2015-2016'
  WHEN games.SEASON = '2016' THEN '2016-2017'
  WHEN games.SEASON = '2017' THEN '2017-2018'
  WHEN games.SEASON = '2018' THEN '2018-2019'
  WHEN games.SEASON = '2019' THEN '2019-2020'
  WHEN games.SEASON = '2020' THEN '2020-2021'
  END as Temporada 
 from 
	games_details
 inner join
	games on games_details.game_id = games.game_id
 inner join 
	teams on games_details.TEAM_ID = teams.TEAM_ID   
 where 
	games.season  between '2010' and '2019' 
 group by
	temporada,nome_jogador, time
 order by 
	Pontos desc
	limit 10;

  -- Top 10 + assistências da década
SELECT 
   games_details.player_name as nome_jogador,
	concat(games_details.TEAM_CITY,' ', teams.nickname) as time,
	sum(games_details.ast) as assistências, 
	count(games_details.game_id) as jogos,
	CASE
  WHEN games.SEASON = '2010' THEN '2010-2011'
WHEN games.SEASON = '2012' THEN '2012-2013'
  WHEN games.SEASON = '2013' THEN '2013-2014'
  WHEN games.SEASON = '2014' THEN '2014-2015'
  WHEN games.SEASON = '2015' THEN '2015-2016'
  WHEN games.SEASON = '2016' THEN '2016-2017'
  WHEN games.SEASON = '2017' THEN '2017-2018'
  WHEN games.SEASON = '2018' THEN '2018-2019'
  WHEN games.SEASON = '2019' THEN '2019-2020'
  WHEN games.SEASON = '2020' THEN '2020-2021'
  END as Temporada 
 from 
	games_details
 inner join 
	games on games_details.game_id = games.game_id
 inner join 
	teams on games_details.TEAM_ID = teams.TEAM_ID
 where
	games.season between '2010' and '2019'  
 group by 
	temporada,nome_jogador, time
 order by 
	assistências desc
 limit 10  ; 

 -- Top 10 clubes mais antigos.
select 
	MIN(min_year) as `Ano de fundação do clube`,
    concat(city, ' ', nickname) as time
 from 
	teams 
 group by
	 time 
 order by 
	`Ano de fundação do clube`  limit 10 ;
  
-- Top 10 times mais defensivos
select TEAM_ABBREVIATION, sum(dreb) as rebotes_denfesivos,
sum(reb) as rebotes ,sum(blk) as bloqueios 
from games_details group by TEAM_ABBREVIATION
 order by rebotes_denfesivos desc, rebotes desc , bloqueios desc
 limit 10;

-- Top 10 jogadores mais defensivos
select PLAYER_NAME, sum(dreb) as rebotes_denfesivos,
sum(reb) as rebotes ,sum(blk) as bloqueios 
from games_details group by PLAYER_NAME
order by rebotes_denfesivos desc, rebotes desc , bloqueios desc
limit 10 ;
 
-- Top 10 dos time que mais converteram arremesos da década
select TEAM_ABBREVIATION,sum(FGM) as arremessos from games_details
group by TEAM_ABBREVIATION order by arremessos desc
limit 10;

-- TOP 10 JOGADORES MAIS OFENSIVOS EM MÉDIA POR UMA TEMPORADA
SELECT PLAYER_NAME Jogador, CONCAT(gd.TEAM_CITY,' ',t.NICKNAME) Time, ROUND((SUM(PTS) + SUM(OREB) + SUM(AST) - SUM(gd.TO))/COUNT(gd.GAME_ID),2) Resultado,
	CASE
		WHEN g.SEASON = '2010' THEN '2010-2011'
		WHEN g.SEASON = '2011' THEN '2011-2012'
		WHEN g.SEASON = '2012' THEN '2012-2013'
		WHEN g.SEASON = '2013' THEN '2013-2014'
		WHEN g.SEASON = '2014' THEN '2014-2015'
		WHEN g.SEASON = '2015' THEN '2015-2016'
		WHEN g.SEASON = '2016' THEN '2016-2017'
		WHEN g.SEASON = '2017' THEN '2017-2018'
		WHEN g.SEASON = '2018' THEN '2018-2019'
		WHEN g.SEASON = '2019' THEN '2019-2020'
		WHEN g.SEASON = '2020' THEN '2020-2021'
	END as Temporada
FROM games_details gd
INNER JOIN teams t ON t.TEAM_ID = gd.TEAM_ID
INNER JOIN games g ON g.GAME_ID = gd.GAME_ID
WHERE SEASON BETWEEN 2010 AND 2019
GROUP BY Jogador, Time, Temporada
HAVING COUNT(gd.GAME_ID) > 65
ORDER BY Resultado DESC
LIMIT 10;

-- TOP 10 TIMES MAIS OFENSIVOS EM UMA TEMPORADA
SELECT CONCAT(gd.TEAM_CITY,' ',t.NICKNAME) Time, SUM(gd.PTS) + SUM(gd.OREB) + SUM(gd.AST) - SUM(gd.TO) Ofensividade,
	CASE
		WHEN g.SEASON = '2010' THEN '2010-2011'
		WHEN g.SEASON = '2011' THEN '2011-2012'
		WHEN g.SEASON = '2012' THEN '2012-2013'
		WHEN g.SEASON = '2013' THEN '2013-2014'
		WHEN g.SEASON = '2014' THEN '2014-2015'
		WHEN g.SEASON = '2015' THEN '2015-2016'
		WHEN g.SEASON = '2016' THEN '2016-2017'
		WHEN g.SEASON = '2017' THEN '2017-2018'
		WHEN g.SEASON = '2018' THEN '2018-2019'
		WHEN g.SEASON = '2019' THEN '2019-2020'
		WHEN g.SEASON = '2020' THEN '2020-2021'
	END as Temporada
FROM games_details gd
INNER JOIN teams t ON t.TEAM_ID = gd.TEAM_ID
INNER JOIN games g ON g.GAME_ID = gd.GAME_ID
WHERE SEASON BETWEEN 2010 AND 2019
GROUP BY Time, Temporada
ORDER BY Ofensividade DESC
LIMIT 10;

-- TOP 10 JOGADORES COM MAIS ROUBADAS DE BOLA EM UMA TEMPORADA
SELECT gd.PLAYER_NAME Jogador, CONCAT(gd.TEAM_CITY,' ',t.NICKNAME) Time, COUNT(gd.GAME_ID) Jogos, SUM(STL) `Bola Roubada`,
CASE
		WHEN g.SEASON = '2010' THEN '2010-2011'
		WHEN g.SEASON = '2011' THEN '2011-2012'
		WHEN g.SEASON = '2012' THEN '2012-2013'
		WHEN g.SEASON = '2013' THEN '2013-2014'
		WHEN g.SEASON = '2014' THEN '2014-2015'
		WHEN g.SEASON = '2015' THEN '2015-2016'
		WHEN g.SEASON = '2016' THEN '2016-2017'
		WHEN g.SEASON = '2017' THEN '2017-2018'
		WHEN g.SEASON = '2018' THEN '2018-2019'
		WHEN g.SEASON = '2019' THEN '2019-2020'
		WHEN g.SEASON = '2020' THEN '2020-2021'
	END as Temporada
FROM  games_details gd
INNER JOIN teams t ON t.TEAM_ID = gd.TEAM_ID
INNER JOIN games g ON g.GAME_ID = gd.GAME_ID
WHERE SEASON BETWEEN 2010 AND 2019
GROUP BY Jogador, Time, Temporada
ORDER BY `Bola Roubada` DESC
LIMIT 10;
