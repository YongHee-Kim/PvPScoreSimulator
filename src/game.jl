type Game
    title::String
    elapsed_time::TimePeriod
    league::League
    players::Vector{Player}
    player_group::Int
    tick_interval::TimePeriod

    function Game(title::String, player_group::Int, players::Vector{Player})
        begin
            # 공격자 플레이어 리스트로 매치메이킹
            f = Symbol("$(title)_matchmaking")
            @eval matchmaking(g::Game, x::Vector{Player}) = $f(g, x)
            # P1, P2의 승패 가린 후 socring반영
            f = Symbol("$(title)_duel!")
            @eval duel!(g::Game, P1::Player, P2::Player) = $f(g, P1,P2)
        end
        elapsed_time = zero(eltype(map(x->x.play_interval, players)))
        league = @eval $(Symbol("$(title)_init_league"))()

        # play_interval이 여러개면 tick_interval은 공약수...
        tick_interval = gcd(unique(map(x->Int(x.play_interval), players))) / player_group
        #tick_interval이 정수가 되도록 player_group을 정해야 한다.
        tick_interval = convert(typeof(elapsed_time), tick_interval)

        println("tick:", tick_interval, "의 Game이 생성되었습니다.")
        new(title, elapsed_time, league, players, player_group, tick_interval)
    end
end
population(g::Game) = length(g.players)
active_player(g::Game) = filter(x->x.expiration > g.elapsed_time, g.players)


function run(g::Game)
    function filter_ofender(x::Player)
        Int((g.elapsed_time + (x.uid % g.player_group)*g.tick_interval) % x.play_interval) == 0
    end
    g.elapsed_time += g.tick_interval

    # GAME에 지정된 player group 수와 player들의 play_interval을 반영해서 이번 tick에 공격할 유저 선택
    ofender = filter(x->filter_ofender(x), g.players)
    if length(ofender) > 0
        map(x->x.protection = zero(x.protection), ofender) # 보호막 제거
        defender = matchmaking(g, ofender)
        map((x,y)->duel!(g, x, y), ofender, defender)
    end
    # println(g.elapsed_time)


    # 기록하는 Log 시스템 필요
    # 일단 여기서 정지 2016.10.07

end
