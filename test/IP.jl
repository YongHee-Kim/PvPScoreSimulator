using Base.Test

include("../src/PvPScoreSimulator.jl")

# 승률, 플레이 횟수 분포
n = 10000
승률 = Truncated(Normal(0.7, 0.16), 0.05, 0.95)
승률 = rand(승률, n)
일간플레이횟수 = [fill(3, 6000);fill(9, 3500);fill(30, 500)]
플레이간격 = map(Minute, round(Int, 1440 ./ 일간플레이횟수))

유저풀 = map((x,y)->Player(;winning_rate=x, play_interval=y), 승률, 플레이간격)
# plt = histogram(play_time, w=1, title="play_time")

gamename = "?"
GAME = Game(gamename, 4, 유저풀)

for i in 1:1000
    run(GAME)
end
