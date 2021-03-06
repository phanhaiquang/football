User.create!([
  {email: 'test@example.com', password: 'password', admin: true},
  {email: 'user@example.com', password: '1234abcd', admin: false}
])

Cup.create!([
  {name: "Euro 2016", host: "France", logo: "euro2016.jpg", start_date: "2016-06-10", end_date: "2016-07-10"},
  {name: "World Cup 2018", host: "Russia", logo: "worldcup2018.jpg", start_date: "2018-06-14", end_date: "2018-07-15"}
]) if Cup.count == 0

Team.create!([
  {name: "Croatia", score: nil, coach: nil, status: true},
  {name: "Czech Republic", score: nil, coach: nil, status: true},
  {name: "Germany", score: nil, coach: nil, status: true},
  {name: "Northern Ireland", score: nil, coach: nil, status: true},
  {name: "Poland", score: nil, coach: nil, status: true},
  {name: "Republic of Ireland", score: nil, coach: nil, status: true},
  {name: "Spain", score: nil, coach: nil, status: true},
  {name: "Sweden", score: nil, coach: nil, status: true},
  {name: "Turkey", score: nil, coach: nil, status: true},
  {name: "Ukraine", score: nil, coach: nil, status: true},
  {name: "France", score: 3, coach: nil, status: true},
  {name: "Romania", score: 0, coach: nil, status: true},
  {name: "Albania", score: 0, coach: nil, status: true},
  {name: "Switzerland", score: 3, coach: nil, status: true},
  {name: "Wales", score: 3, coach: nil, status: true},
  {name: "Slovakia", score: 0, coach: nil, status: true},
  {name: "England", score: 1, coach: nil, status: true},
  {name: "Russia", score: 1, coach: nil, status: true},
  {name: "Belgium", score: 0, coach: nil, status: true},
  {name: "Italy", score: 0, coach: nil, status: true},
  {name: "Austria", score: 0, coach: nil, status: true},
  {name: "Hungary", score: 0, coach: nil, status: true},
  {name: "Portugal", score: 0, coach: nil, status: true},
  {name: "Iceland", score: 0, coach: nil, status: true}
]) if Team.count == 0

Match.create!([
  {team1_id: 7, team2_id: 16, time: "2016-06-10 19:00:00"},
  {team1_id: 1, team2_id: 21, time: "2016-06-11 13:00:00"},
  {team1_id: 24, team2_id: 18, time: "2016-06-11 16:00:00"},
  {team1_id: 6, team2_id: 17, time: "2016-06-11 19:00:00"},
  {team1_id: 22, team2_id: 4, time: "2016-06-12 13:00:00"},
  {team1_id: 13, team2_id: 12, time: "2016-06-12 16:00:00"},
  {team1_id: 8, team2_id: 23, time: "2016-06-12 19:00:00"},
  {team1_id: 19, team2_id: 5, time: "2016-06-13 13:00:00"},
  {team1_id: 15, team2_id: 20, time: "2016-06-13 16:00:00"},
  {team1_id: 3, team2_id: 11, time: "2016-06-13 19:00:00"},
  {team1_id: 2, team2_id: 9, time: "2016-06-14 16:00:00"},
  {team1_id: 14, team2_id: 10, time: "2016-06-14 19:00:00"},
  {team1_id: 17, team2_id: 18, time: "2016-06-15 13:00:00"},
  {team1_id: 16, team2_id: 21, time: "2016-06-15 16:00:00"},
  {team1_id: 7, team2_id: 1, time: "2016-06-15 19:00:00"},
  {team1_id: 6, team2_id: 24, time: "2016-06-16 13:00:00"},
  {team1_id: 23, team2_id: 12, time: "2016-06-16 16:00:00"},
  {team1_id: 8, team2_id: 13, time: "2016-06-16 19:00:00"},
  {team1_id: 11, team2_id: 20, time: "2016-06-17 13:00:00"},
  {team1_id: 5, team2_id: 4, time: "2016-06-17 16:00:00"},
  {team1_id: 19, team2_id: 22, time: "2016-06-17 19:00:00"},
  {team1_id: 3, team2_id: 15, time: "2016-06-18 13:00:00"},
  {team1_id: 10, team2_id: 9, time: "2016-06-18 16:00:00"},
  {team1_id: 14, team2_id: 2, time: "2016-06-18 19:00:00"},
  {team1_id: 16, team2_id: 1, time: "2016-06-19 19:00:00"},
  {team1_id: 21, team2_id: 7, time: "2016-06-19 19:00:00"},
  {team1_id: 17, team2_id: 24, time: "2016-06-20 19:00:00"},
  {team1_id: 18, team2_id: 6, time: "2016-06-20 19:00:00"},
  {team1_id: 23, team2_id: 13, time: "2016-06-21 16:00:00"},
  {team1_id: 12, team2_id: 8, time: "2016-06-21 16:00:00"},
  {team1_id: 5, team2_id: 22, time: "2016-06-21 19:00:00"},
  {team1_id: 4, team2_id: 19, time: "2016-06-21 19:00:00"},
  {team1_id: 9, team2_id: 14, time: "2016-06-22 16:00:00"},
  {team1_id: 10, team2_id: 2, time: "2016-06-22 16:00:00"},
  {team1_id: 20, team2_id: 3, time: "2016-06-22 19:00:00"},
  {team1_id: 11, team2_id: 15, time: "2016-06-22 19:00:00"}
]) if Match.count == 0

if Score.count == 0
  User.all.each do |u|
    Cup.all.each do |c|
      Score.create({:user_id => u.id, :cup_id => c.id, :score => 0});
    end
  end
end
