type Player
    uid::UInt32
    play_interval::TimePeriod
    score::Float64
    league_tier::Int16
    winning_rate::Float64
    elo_rate::Float64
    expiration::TimePeriod
    protection::TimePeriod
    let counter = UInt32(0) #uid 발급
        function Player(;play_interval=Minute(180), score=0.0, league_tier=Int16(0),
            winning_rate=0.0, elo_rate=0.0, expiration=typemax(Minute), protection=zero(Minute))

            new(counter+=1, play_interval, score, league_tier, winning_rate, elo_rate, expiration, protection)
        end
    end
end
tier(p::Player) = p.league_tier

tierisless(x::Player, y::Player) = tier(x) < tier(y)
