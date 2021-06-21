-- 10 jogadores que obteram as maiores médias de arremessos por ano
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

-- 10 jogadores que mais jogaram em minutos por ano
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


-- 10 times que mais venceu em casa por ano
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

-- Cestinhas(jogadores que mais pontuaram) na década
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

  -- 10 jogadores com + assistências da década
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

 -- 10 clubes mais antigos.
select 
	MIN(min_year) as `Ano de fundação do clube`,
    concat(city, ' ', nickname) as time
 from 
	teams 
 group by
	 time 
 order by 
	`Ano de fundação do clube`  limit 10 ;
