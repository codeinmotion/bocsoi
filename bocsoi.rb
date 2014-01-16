PICK = [1,2,3]

def c_take_soi c_turn
  take = choose_number_of_soi @num_soi, c_turn

  take[0]
end

def choose_number_of_soi num_soi, c_turn
  scores = PICK.map { |num| score(num_soi - num, !c_turn) }.compact
  c_turn ? score_take = scores.max : score_take = scores.min
  # puts "--> so soi #{num_soi}, cturn #{c_turn} boc #{PICK[scores.rindex(score_take)]} diem #{score_take}"

  [PICK[scores.rindex(score_take)], score_take]
end

def score num_soi, c_turn
  if num_soi.eql? 1
    point = 1
  elsif num_soi.eql? 0
    point = -1
  elsif num_soi < 0
    point = nil
  else
    point = choose_number_of_soi(num_soi, c_turn)[1]
  end

  # puts "Call score for #{num_soi}, cturn #{c_turn}, point #{point}"

  point
end

def read_value
  print "Nhap so luong soi muon choi "
  @num_soi = gets.to_i

  print "Di truoc hen (y/n): "
  s = gets

  @first_move = true if s.chomp != 'y'&&'Y'
end

def player_take
  take = 0
  begin
    print "Ban boc may vien soi "
    take = gets.to_i
  end while take < PICK.min || take > PICK.max

  take
end

def play_game
  read_value
  c_turn = @first_move

  begin
    if @num_soi.eql? 1
      puts "\n===== Ten ten ten ====="
      c_turn ? puts("Hu hu, thua ko co phuc") : puts("Yeah, ban thua roi ha ha ha ha")
      exit
    end

    if @num_soi.eql? 0
      puts "\n===== Ten ten ten ====="
      c_turn ? puts("Ban nghi ban thong minh hon tui sao????") : puts("Sac, choi lai ko, thua roi sao:(((")
      exit
    end

    if c_turn
      take = c_take_soi c_turn
      puts "May boc #{take}"
    else
      take = player_take
    end

    @num_soi -= take
    c_turn = !c_turn
    puts "---> Con lai #{@num_soi}"
  end while true
end

play_game
