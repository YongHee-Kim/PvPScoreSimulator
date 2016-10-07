



# elo 승률 계산 공식으로 승부 결정

# 공격자 방어자 입력받아서 결과와 변동할 elo 점수를 반환하는게 나을듯
function PvP_elo(ab::Vector, Ra::Float64, Rb::Float64)
    Ea = 1 / (1+10^(Rb - Ra))

    rand() <= Ea ? result = [ab[1],ab[2]] : result = [ab[2],ab[1]]


    win = true # false
    score = 0.0
    return win, score
end
