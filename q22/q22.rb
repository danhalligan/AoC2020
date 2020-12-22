
def round(decks)
  play = [decks[0].shift, decks[1].shift]
  if decks[0].length >= play[0] && decks[1].length >= play[1]
    res = game([decks[0].take(play[0]), decks[1].take(play[1])])
    winner = res[:winner]
  else
    winner = play[0] > play[1] ? 0 : 1
  end
  decks[winner] += winner == 1 ? play.reverse : play
  {winner: winner, decks: decks}
end

def game(decks)
  rounds = []
  while decks.map{|d| d.length > 0}.all?
    chash = decks.hash
    if rounds.include? chash
      winner = 0
      break
    end
    rounds << chash
    out = round(decks)
    winner = out[:winner]
    decks = out[:decks]
  end
  {winner: winner, decks: decks}
end

def score(r)
  d = r[:decks][r[:winner]]
  d.zip((1..d.length).to_a.reverse).map { |x| x[0]*x[1] }.sum
end

r = game([[9,2,6,3,1], [5,8,4,7,10]])
puts score(r)

dat = IO.readlines("input.txt", chomp: true)
dat = [dat[1..25].map(&:to_i), dat[28..53].map(&:to_i)]
r = game(dat)
puts score(r)
