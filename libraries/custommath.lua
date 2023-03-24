
function math.vdist(p1, p2, q1, q2)
    local qp1 = q1-p1
    local qp2 = q2-p2
    return math.sqrt(qp1*qp1+qp2*qp2)
end


