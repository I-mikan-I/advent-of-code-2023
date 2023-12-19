(set-logic ALL)
(declare-sort N 0)
(declare-datatype Direction ( (Left) (Right) (Down) (Up) ))
(define-fun get_weight ((x Real)) Int (ite (= x (- 1)) 9999999 (ite (= x 0000) 2
	(ite (= x 0001) 4
	(ite (= x 0002) 1
	(ite (= x 0003) 3
	(ite (= x 0004) 4
	(ite (= x 0005) 3
	(ite (= x 0006) 2
	(ite (= x 0007) 3
	(ite (= x 0008) 1
	(ite (= x 0009) 1
	(ite (= x 00010) 3
	(ite (= x 00011) 2
	(ite (= x 00012) 3
	(ite (= x 1000) 3
	(ite (= x 1001) 2
	(ite (= x 1002) 1
	(ite (= x 1003) 5
	(ite (= x 1004) 4
	(ite (= x 1005) 5
	(ite (= x 1006) 3
	(ite (= x 1007) 5
	(ite (= x 1008) 3
	(ite (= x 1009) 5
	(ite (= x 10010) 6
	(ite (= x 10011) 2
	(ite (= x 10012) 3
	(ite (= x 2000) 3
	(ite (= x 2001) 2
	(ite (= x 2002) 5
	(ite (= x 2003) 5
	(ite (= x 2004) 2
	(ite (= x 2005) 4
	(ite (= x 2006) 5
	(ite (= x 2007) 6
	(ite (= x 2008) 5
	(ite (= x 2009) 4
	(ite (= x 20010) 2
	(ite (= x 20011) 5
	(ite (= x 20012) 4
	(ite (= x 3000) 3
	(ite (= x 3001) 4
	(ite (= x 3002) 4
	(ite (= x 3003) 6
	(ite (= x 3004) 5
	(ite (= x 3005) 8
	(ite (= x 3006) 5
	(ite (= x 3007) 8
	(ite (= x 3008) 4
	(ite (= x 3009) 5
	(ite (= x 30010) 4
	(ite (= x 30011) 5
	(ite (= x 30012) 2
	(ite (= x 4000) 4
	(ite (= x 4001) 5
	(ite (= x 4002) 4
	(ite (= x 4003) 6
	(ite (= x 4004) 6
	(ite (= x 4005) 5
	(ite (= x 4006) 7
	(ite (= x 4007) 8
	(ite (= x 4008) 6
	(ite (= x 4009) 7
	(ite (= x 40010) 5
	(ite (= x 40011) 3
	(ite (= x 40012) 6
	(ite (= x 5000) 1
	(ite (= x 5001) 4
	(ite (= x 5002) 3
	(ite (= x 5003) 8
	(ite (= x 5004) 5
	(ite (= x 5005) 9
	(ite (= x 5006) 8
	(ite (= x 5007) 7
	(ite (= x 5008) 9
	(ite (= x 5009) 8
	(ite (= x 50010) 4
	(ite (= x 50011) 5
	(ite (= x 50012) 4
	(ite (= x 6000) 4
	(ite (= x 6001) 4
	(ite (= x 6002) 5
	(ite (= x 6003) 7
	(ite (= x 6004) 8
	(ite (= x 6005) 7
	(ite (= x 6006) 6
	(ite (= x 6007) 9
	(ite (= x 6008) 8
	(ite (= x 6009) 7
	(ite (= x 60010) 7
	(ite (= x 60011) 6
	(ite (= x 60012) 6
	(ite (= x 7000) 3
	(ite (= x 7001) 6
	(ite (= x 7002) 3
	(ite (= x 7003) 7
	(ite (= x 7004) 8
	(ite (= x 7005) 7
	(ite (= x 7006) 7
	(ite (= x 7007) 9
	(ite (= x 7008) 7
	(ite (= x 7009) 9
	(ite (= x 70010) 6
	(ite (= x 70011) 5
	(ite (= x 70012) 3
	(ite (= x 8000) 4
	(ite (= x 8001) 6
	(ite (= x 8002) 5
	(ite (= x 8003) 4
	(ite (= x 8004) 9
	(ite (= x 8005) 6
	(ite (= x 8006) 7
	(ite (= x 8007) 9
	(ite (= x 8008) 8
	(ite (= x 8009) 6
	(ite (= x 80010) 8
	(ite (= x 80011) 8
	(ite (= x 80012) 7
	(ite (= x 9000) 4
	(ite (= x 9001) 5
	(ite (= x 9002) 6
	(ite (= x 9003) 4
	(ite (= x 9004) 6
	(ite (= x 9005) 7
	(ite (= x 9006) 9
	(ite (= x 9007) 9
	(ite (= x 9008) 8
	(ite (= x 9009) 6
	(ite (= x 90010) 4
	(ite (= x 90011) 5
	(ite (= x 90012) 3
	(ite (= x 10000) 1
	(ite (= x 10001) 2
	(ite (= x 10002) 2
	(ite (= x 10003) 4
	(ite (= x 10004) 6
	(ite (= x 10005) 8
	(ite (= x 10006) 6
	(ite (= x 10007) 8
	(ite (= x 10008) 6
	(ite (= x 10009) 5
	(ite (= x 100010) 5
	(ite (= x 100011) 6
	(ite (= x 100012) 3
	(ite (= x 11000) 2
	(ite (= x 11001) 5
	(ite (= x 11002) 4
	(ite (= x 11003) 6
	(ite (= x 11004) 5
	(ite (= x 11005) 4
	(ite (= x 11006) 8
	(ite (= x 11007) 8
	(ite (= x 11008) 8
	(ite (= x 11009) 7
	(ite (= x 110010) 7
	(ite (= x 110011) 3
	(ite (= x 110012) 5
	(ite (= x 12000) 4
	(ite (= x 12001) 3
	(ite (= x 12002) 2
	(ite (= x 12003) 2
	(ite (= x 12004) 6
	(ite (= x 12005) 7
	(ite (= x 12006) 4
	(ite (= x 12007) 6
	(ite (= x 12008) 5
	(ite (= x 12009) 5
	(ite (= x 120010) 5
	(ite (= x 120011) 3
	(ite (= x 120012) 3
	0)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert (= 0 (get_weight 99900999)))
(define-fun move ((x Int)(d Direction)) Int (ite (= x 99900999) 99900999 (ite (= x 120012) 99900999 (ite (and (= d Left)(= x 0000)) (- 1)
	(ite (and (= d Left)(= x 0001)) 0000
	(ite (and (= d Left)(= x 0002)) 0001
	(ite (and (= d Left)(= x 0003)) 0002
	(ite (and (= d Left)(= x 0004)) 0003
	(ite (and (= d Left)(= x 0005)) 0004
	(ite (and (= d Left)(= x 0006)) 0005
	(ite (and (= d Left)(= x 0007)) 0006
	(ite (and (= d Left)(= x 0008)) 0007
	(ite (and (= d Left)(= x 0009)) 0008
	(ite (and (= d Left)(= x 00010)) 0009
	(ite (and (= d Left)(= x 00011)) 00010
	(ite (and (= d Left)(= x 00012)) 00011
	(ite (and (= d Left)(= x 1000)) (- 1)
	(ite (and (= d Left)(= x 1001)) 1000
	(ite (and (= d Left)(= x 1002)) 1001
	(ite (and (= d Left)(= x 1003)) 1002
	(ite (and (= d Left)(= x 1004)) 1003
	(ite (and (= d Left)(= x 1005)) 1004
	(ite (and (= d Left)(= x 1006)) 1005
	(ite (and (= d Left)(= x 1007)) 1006
	(ite (and (= d Left)(= x 1008)) 1007
	(ite (and (= d Left)(= x 1009)) 1008
	(ite (and (= d Left)(= x 10010)) 1009
	(ite (and (= d Left)(= x 10011)) 10010
	(ite (and (= d Left)(= x 10012)) 10011
	(ite (and (= d Left)(= x 2000)) (- 1)
	(ite (and (= d Left)(= x 2001)) 2000
	(ite (and (= d Left)(= x 2002)) 2001
	(ite (and (= d Left)(= x 2003)) 2002
	(ite (and (= d Left)(= x 2004)) 2003
	(ite (and (= d Left)(= x 2005)) 2004
	(ite (and (= d Left)(= x 2006)) 2005
	(ite (and (= d Left)(= x 2007)) 2006
	(ite (and (= d Left)(= x 2008)) 2007
	(ite (and (= d Left)(= x 2009)) 2008
	(ite (and (= d Left)(= x 20010)) 2009
	(ite (and (= d Left)(= x 20011)) 20010
	(ite (and (= d Left)(= x 20012)) 20011
	(ite (and (= d Left)(= x 3000)) (- 1)
	(ite (and (= d Left)(= x 3001)) 3000
	(ite (and (= d Left)(= x 3002)) 3001
	(ite (and (= d Left)(= x 3003)) 3002
	(ite (and (= d Left)(= x 3004)) 3003
	(ite (and (= d Left)(= x 3005)) 3004
	(ite (and (= d Left)(= x 3006)) 3005
	(ite (and (= d Left)(= x 3007)) 3006
	(ite (and (= d Left)(= x 3008)) 3007
	(ite (and (= d Left)(= x 3009)) 3008
	(ite (and (= d Left)(= x 30010)) 3009
	(ite (and (= d Left)(= x 30011)) 30010
	(ite (and (= d Left)(= x 30012)) 30011
	(ite (and (= d Left)(= x 4000)) (- 1)
	(ite (and (= d Left)(= x 4001)) 4000
	(ite (and (= d Left)(= x 4002)) 4001
	(ite (and (= d Left)(= x 4003)) 4002
	(ite (and (= d Left)(= x 4004)) 4003
	(ite (and (= d Left)(= x 4005)) 4004
	(ite (and (= d Left)(= x 4006)) 4005
	(ite (and (= d Left)(= x 4007)) 4006
	(ite (and (= d Left)(= x 4008)) 4007
	(ite (and (= d Left)(= x 4009)) 4008
	(ite (and (= d Left)(= x 40010)) 4009
	(ite (and (= d Left)(= x 40011)) 40010
	(ite (and (= d Left)(= x 40012)) 40011
	(ite (and (= d Left)(= x 5000)) (- 1)
	(ite (and (= d Left)(= x 5001)) 5000
	(ite (and (= d Left)(= x 5002)) 5001
	(ite (and (= d Left)(= x 5003)) 5002
	(ite (and (= d Left)(= x 5004)) 5003
	(ite (and (= d Left)(= x 5005)) 5004
	(ite (and (= d Left)(= x 5006)) 5005
	(ite (and (= d Left)(= x 5007)) 5006
	(ite (and (= d Left)(= x 5008)) 5007
	(ite (and (= d Left)(= x 5009)) 5008
	(ite (and (= d Left)(= x 50010)) 5009
	(ite (and (= d Left)(= x 50011)) 50010
	(ite (and (= d Left)(= x 50012)) 50011
	(ite (and (= d Left)(= x 6000)) (- 1)
	(ite (and (= d Left)(= x 6001)) 6000
	(ite (and (= d Left)(= x 6002)) 6001
	(ite (and (= d Left)(= x 6003)) 6002
	(ite (and (= d Left)(= x 6004)) 6003
	(ite (and (= d Left)(= x 6005)) 6004
	(ite (and (= d Left)(= x 6006)) 6005
	(ite (and (= d Left)(= x 6007)) 6006
	(ite (and (= d Left)(= x 6008)) 6007
	(ite (and (= d Left)(= x 6009)) 6008
	(ite (and (= d Left)(= x 60010)) 6009
	(ite (and (= d Left)(= x 60011)) 60010
	(ite (and (= d Left)(= x 60012)) 60011
	(ite (and (= d Left)(= x 7000)) (- 1)
	(ite (and (= d Left)(= x 7001)) 7000
	(ite (and (= d Left)(= x 7002)) 7001
	(ite (and (= d Left)(= x 7003)) 7002
	(ite (and (= d Left)(= x 7004)) 7003
	(ite (and (= d Left)(= x 7005)) 7004
	(ite (and (= d Left)(= x 7006)) 7005
	(ite (and (= d Left)(= x 7007)) 7006
	(ite (and (= d Left)(= x 7008)) 7007
	(ite (and (= d Left)(= x 7009)) 7008
	(ite (and (= d Left)(= x 70010)) 7009
	(ite (and (= d Left)(= x 70011)) 70010
	(ite (and (= d Left)(= x 70012)) 70011
	(ite (and (= d Left)(= x 8000)) (- 1)
	(ite (and (= d Left)(= x 8001)) 8000
	(ite (and (= d Left)(= x 8002)) 8001
	(ite (and (= d Left)(= x 8003)) 8002
	(ite (and (= d Left)(= x 8004)) 8003
	(ite (and (= d Left)(= x 8005)) 8004
	(ite (and (= d Left)(= x 8006)) 8005
	(ite (and (= d Left)(= x 8007)) 8006
	(ite (and (= d Left)(= x 8008)) 8007
	(ite (and (= d Left)(= x 8009)) 8008
	(ite (and (= d Left)(= x 80010)) 8009
	(ite (and (= d Left)(= x 80011)) 80010
	(ite (and (= d Left)(= x 80012)) 80011
	(ite (and (= d Left)(= x 9000)) (- 1)
	(ite (and (= d Left)(= x 9001)) 9000
	(ite (and (= d Left)(= x 9002)) 9001
	(ite (and (= d Left)(= x 9003)) 9002
	(ite (and (= d Left)(= x 9004)) 9003
	(ite (and (= d Left)(= x 9005)) 9004
	(ite (and (= d Left)(= x 9006)) 9005
	(ite (and (= d Left)(= x 9007)) 9006
	(ite (and (= d Left)(= x 9008)) 9007
	(ite (and (= d Left)(= x 9009)) 9008
	(ite (and (= d Left)(= x 90010)) 9009
	(ite (and (= d Left)(= x 90011)) 90010
	(ite (and (= d Left)(= x 90012)) 90011
	(ite (and (= d Left)(= x 10000)) (- 1)
	(ite (and (= d Left)(= x 10001)) 10000
	(ite (and (= d Left)(= x 10002)) 10001
	(ite (and (= d Left)(= x 10003)) 10002
	(ite (and (= d Left)(= x 10004)) 10003
	(ite (and (= d Left)(= x 10005)) 10004
	(ite (and (= d Left)(= x 10006)) 10005
	(ite (and (= d Left)(= x 10007)) 10006
	(ite (and (= d Left)(= x 10008)) 10007
	(ite (and (= d Left)(= x 10009)) 10008
	(ite (and (= d Left)(= x 100010)) 10009
	(ite (and (= d Left)(= x 100011)) 100010
	(ite (and (= d Left)(= x 100012)) 100011
	(ite (and (= d Left)(= x 11000)) (- 1)
	(ite (and (= d Left)(= x 11001)) 11000
	(ite (and (= d Left)(= x 11002)) 11001
	(ite (and (= d Left)(= x 11003)) 11002
	(ite (and (= d Left)(= x 11004)) 11003
	(ite (and (= d Left)(= x 11005)) 11004
	(ite (and (= d Left)(= x 11006)) 11005
	(ite (and (= d Left)(= x 11007)) 11006
	(ite (and (= d Left)(= x 11008)) 11007
	(ite (and (= d Left)(= x 11009)) 11008
	(ite (and (= d Left)(= x 110010)) 11009
	(ite (and (= d Left)(= x 110011)) 110010
	(ite (and (= d Left)(= x 110012)) 110011
	(ite (and (= d Left)(= x 12000)) (- 1)
	(ite (and (= d Left)(= x 12001)) 12000
	(ite (and (= d Left)(= x 12002)) 12001
	(ite (and (= d Left)(= x 12003)) 12002
	(ite (and (= d Left)(= x 12004)) 12003
	(ite (and (= d Left)(= x 12005)) 12004
	(ite (and (= d Left)(= x 12006)) 12005
	(ite (and (= d Left)(= x 12007)) 12006
	(ite (and (= d Left)(= x 12008)) 12007
	(ite (and (= d Left)(= x 12009)) 12008
	(ite (and (= d Left)(= x 120010)) 12009
	(ite (and (= d Left)(= x 120011)) 120010
	(ite (and (= d Left)(= x 120012)) 120011
	(ite (and (= d Right)(= x 0000)) 0001
	(ite (and (= d Right)(= x 0001)) 0002
	(ite (and (= d Right)(= x 0002)) 0003
	(ite (and (= d Right)(= x 0003)) 0004
	(ite (and (= d Right)(= x 0004)) 0005
	(ite (and (= d Right)(= x 0005)) 0006
	(ite (and (= d Right)(= x 0006)) 0007
	(ite (and (= d Right)(= x 0007)) 0008
	(ite (and (= d Right)(= x 0008)) 0009
	(ite (and (= d Right)(= x 0009)) 00010
	(ite (and (= d Right)(= x 00010)) 00011
	(ite (and (= d Right)(= x 00011)) 00012
	(ite (and (= d Right)(= x 00012)) (- 1)
	(ite (and (= d Right)(= x 1000)) 1001
	(ite (and (= d Right)(= x 1001)) 1002
	(ite (and (= d Right)(= x 1002)) 1003
	(ite (and (= d Right)(= x 1003)) 1004
	(ite (and (= d Right)(= x 1004)) 1005
	(ite (and (= d Right)(= x 1005)) 1006
	(ite (and (= d Right)(= x 1006)) 1007
	(ite (and (= d Right)(= x 1007)) 1008
	(ite (and (= d Right)(= x 1008)) 1009
	(ite (and (= d Right)(= x 1009)) 10010
	(ite (and (= d Right)(= x 10010)) 10011
	(ite (and (= d Right)(= x 10011)) 10012
	(ite (and (= d Right)(= x 10012)) (- 1)
	(ite (and (= d Right)(= x 2000)) 2001
	(ite (and (= d Right)(= x 2001)) 2002
	(ite (and (= d Right)(= x 2002)) 2003
	(ite (and (= d Right)(= x 2003)) 2004
	(ite (and (= d Right)(= x 2004)) 2005
	(ite (and (= d Right)(= x 2005)) 2006
	(ite (and (= d Right)(= x 2006)) 2007
	(ite (and (= d Right)(= x 2007)) 2008
	(ite (and (= d Right)(= x 2008)) 2009
	(ite (and (= d Right)(= x 2009)) 20010
	(ite (and (= d Right)(= x 20010)) 20011
	(ite (and (= d Right)(= x 20011)) 20012
	(ite (and (= d Right)(= x 20012)) (- 1)
	(ite (and (= d Right)(= x 3000)) 3001
	(ite (and (= d Right)(= x 3001)) 3002
	(ite (and (= d Right)(= x 3002)) 3003
	(ite (and (= d Right)(= x 3003)) 3004
	(ite (and (= d Right)(= x 3004)) 3005
	(ite (and (= d Right)(= x 3005)) 3006
	(ite (and (= d Right)(= x 3006)) 3007
	(ite (and (= d Right)(= x 3007)) 3008
	(ite (and (= d Right)(= x 3008)) 3009
	(ite (and (= d Right)(= x 3009)) 30010
	(ite (and (= d Right)(= x 30010)) 30011
	(ite (and (= d Right)(= x 30011)) 30012
	(ite (and (= d Right)(= x 30012)) (- 1)
	(ite (and (= d Right)(= x 4000)) 4001
	(ite (and (= d Right)(= x 4001)) 4002
	(ite (and (= d Right)(= x 4002)) 4003
	(ite (and (= d Right)(= x 4003)) 4004
	(ite (and (= d Right)(= x 4004)) 4005
	(ite (and (= d Right)(= x 4005)) 4006
	(ite (and (= d Right)(= x 4006)) 4007
	(ite (and (= d Right)(= x 4007)) 4008
	(ite (and (= d Right)(= x 4008)) 4009
	(ite (and (= d Right)(= x 4009)) 40010
	(ite (and (= d Right)(= x 40010)) 40011
	(ite (and (= d Right)(= x 40011)) 40012
	(ite (and (= d Right)(= x 40012)) (- 1)
	(ite (and (= d Right)(= x 5000)) 5001
	(ite (and (= d Right)(= x 5001)) 5002
	(ite (and (= d Right)(= x 5002)) 5003
	(ite (and (= d Right)(= x 5003)) 5004
	(ite (and (= d Right)(= x 5004)) 5005
	(ite (and (= d Right)(= x 5005)) 5006
	(ite (and (= d Right)(= x 5006)) 5007
	(ite (and (= d Right)(= x 5007)) 5008
	(ite (and (= d Right)(= x 5008)) 5009
	(ite (and (= d Right)(= x 5009)) 50010
	(ite (and (= d Right)(= x 50010)) 50011
	(ite (and (= d Right)(= x 50011)) 50012
	(ite (and (= d Right)(= x 50012)) (- 1)
	(ite (and (= d Right)(= x 6000)) 6001
	(ite (and (= d Right)(= x 6001)) 6002
	(ite (and (= d Right)(= x 6002)) 6003
	(ite (and (= d Right)(= x 6003)) 6004
	(ite (and (= d Right)(= x 6004)) 6005
	(ite (and (= d Right)(= x 6005)) 6006
	(ite (and (= d Right)(= x 6006)) 6007
	(ite (and (= d Right)(= x 6007)) 6008
	(ite (and (= d Right)(= x 6008)) 6009
	(ite (and (= d Right)(= x 6009)) 60010
	(ite (and (= d Right)(= x 60010)) 60011
	(ite (and (= d Right)(= x 60011)) 60012
	(ite (and (= d Right)(= x 60012)) (- 1)
	(ite (and (= d Right)(= x 7000)) 7001
	(ite (and (= d Right)(= x 7001)) 7002
	(ite (and (= d Right)(= x 7002)) 7003
	(ite (and (= d Right)(= x 7003)) 7004
	(ite (and (= d Right)(= x 7004)) 7005
	(ite (and (= d Right)(= x 7005)) 7006
	(ite (and (= d Right)(= x 7006)) 7007
	(ite (and (= d Right)(= x 7007)) 7008
	(ite (and (= d Right)(= x 7008)) 7009
	(ite (and (= d Right)(= x 7009)) 70010
	(ite (and (= d Right)(= x 70010)) 70011
	(ite (and (= d Right)(= x 70011)) 70012
	(ite (and (= d Right)(= x 70012)) (- 1)
	(ite (and (= d Right)(= x 8000)) 8001
	(ite (and (= d Right)(= x 8001)) 8002
	(ite (and (= d Right)(= x 8002)) 8003
	(ite (and (= d Right)(= x 8003)) 8004
	(ite (and (= d Right)(= x 8004)) 8005
	(ite (and (= d Right)(= x 8005)) 8006
	(ite (and (= d Right)(= x 8006)) 8007
	(ite (and (= d Right)(= x 8007)) 8008
	(ite (and (= d Right)(= x 8008)) 8009
	(ite (and (= d Right)(= x 8009)) 80010
	(ite (and (= d Right)(= x 80010)) 80011
	(ite (and (= d Right)(= x 80011)) 80012
	(ite (and (= d Right)(= x 80012)) (- 1)
	(ite (and (= d Right)(= x 9000)) 9001
	(ite (and (= d Right)(= x 9001)) 9002
	(ite (and (= d Right)(= x 9002)) 9003
	(ite (and (= d Right)(= x 9003)) 9004
	(ite (and (= d Right)(= x 9004)) 9005
	(ite (and (= d Right)(= x 9005)) 9006
	(ite (and (= d Right)(= x 9006)) 9007
	(ite (and (= d Right)(= x 9007)) 9008
	(ite (and (= d Right)(= x 9008)) 9009
	(ite (and (= d Right)(= x 9009)) 90010
	(ite (and (= d Right)(= x 90010)) 90011
	(ite (and (= d Right)(= x 90011)) 90012
	(ite (and (= d Right)(= x 90012)) (- 1)
	(ite (and (= d Right)(= x 10000)) 10001
	(ite (and (= d Right)(= x 10001)) 10002
	(ite (and (= d Right)(= x 10002)) 10003
	(ite (and (= d Right)(= x 10003)) 10004
	(ite (and (= d Right)(= x 10004)) 10005
	(ite (and (= d Right)(= x 10005)) 10006
	(ite (and (= d Right)(= x 10006)) 10007
	(ite (and (= d Right)(= x 10007)) 10008
	(ite (and (= d Right)(= x 10008)) 10009
	(ite (and (= d Right)(= x 10009)) 100010
	(ite (and (= d Right)(= x 100010)) 100011
	(ite (and (= d Right)(= x 100011)) 100012
	(ite (and (= d Right)(= x 100012)) (- 1)
	(ite (and (= d Right)(= x 11000)) 11001
	(ite (and (= d Right)(= x 11001)) 11002
	(ite (and (= d Right)(= x 11002)) 11003
	(ite (and (= d Right)(= x 11003)) 11004
	(ite (and (= d Right)(= x 11004)) 11005
	(ite (and (= d Right)(= x 11005)) 11006
	(ite (and (= d Right)(= x 11006)) 11007
	(ite (and (= d Right)(= x 11007)) 11008
	(ite (and (= d Right)(= x 11008)) 11009
	(ite (and (= d Right)(= x 11009)) 110010
	(ite (and (= d Right)(= x 110010)) 110011
	(ite (and (= d Right)(= x 110011)) 110012
	(ite (and (= d Right)(= x 110012)) (- 1)
	(ite (and (= d Right)(= x 12000)) 12001
	(ite (and (= d Right)(= x 12001)) 12002
	(ite (and (= d Right)(= x 12002)) 12003
	(ite (and (= d Right)(= x 12003)) 12004
	(ite (and (= d Right)(= x 12004)) 12005
	(ite (and (= d Right)(= x 12005)) 12006
	(ite (and (= d Right)(= x 12006)) 12007
	(ite (and (= d Right)(= x 12007)) 12008
	(ite (and (= d Right)(= x 12008)) 12009
	(ite (and (= d Right)(= x 12009)) 120010
	(ite (and (= d Right)(= x 120010)) 120011
	(ite (and (= d Right)(= x 120011)) 120012
	(ite (and (= d Right)(= x 120012)) (- 1)
	(ite (and (= d Down)(= x 0000)) 1000
	(ite (and (= d Down)(= x 0001)) 1001
	(ite (and (= d Down)(= x 0002)) 1002
	(ite (and (= d Down)(= x 0003)) 1003
	(ite (and (= d Down)(= x 0004)) 1004
	(ite (and (= d Down)(= x 0005)) 1005
	(ite (and (= d Down)(= x 0006)) 1006
	(ite (and (= d Down)(= x 0007)) 1007
	(ite (and (= d Down)(= x 0008)) 1008
	(ite (and (= d Down)(= x 0009)) 1009
	(ite (and (= d Down)(= x 00010)) 10010
	(ite (and (= d Down)(= x 00011)) 10011
	(ite (and (= d Down)(= x 00012)) 10012
	(ite (and (= d Down)(= x 1000)) 2000
	(ite (and (= d Down)(= x 1001)) 2001
	(ite (and (= d Down)(= x 1002)) 2002
	(ite (and (= d Down)(= x 1003)) 2003
	(ite (and (= d Down)(= x 1004)) 2004
	(ite (and (= d Down)(= x 1005)) 2005
	(ite (and (= d Down)(= x 1006)) 2006
	(ite (and (= d Down)(= x 1007)) 2007
	(ite (and (= d Down)(= x 1008)) 2008
	(ite (and (= d Down)(= x 1009)) 2009
	(ite (and (= d Down)(= x 10010)) 20010
	(ite (and (= d Down)(= x 10011)) 20011
	(ite (and (= d Down)(= x 10012)) 20012
	(ite (and (= d Down)(= x 2000)) 3000
	(ite (and (= d Down)(= x 2001)) 3001
	(ite (and (= d Down)(= x 2002)) 3002
	(ite (and (= d Down)(= x 2003)) 3003
	(ite (and (= d Down)(= x 2004)) 3004
	(ite (and (= d Down)(= x 2005)) 3005
	(ite (and (= d Down)(= x 2006)) 3006
	(ite (and (= d Down)(= x 2007)) 3007
	(ite (and (= d Down)(= x 2008)) 3008
	(ite (and (= d Down)(= x 2009)) 3009
	(ite (and (= d Down)(= x 20010)) 30010
	(ite (and (= d Down)(= x 20011)) 30011
	(ite (and (= d Down)(= x 20012)) 30012
	(ite (and (= d Down)(= x 3000)) 4000
	(ite (and (= d Down)(= x 3001)) 4001
	(ite (and (= d Down)(= x 3002)) 4002
	(ite (and (= d Down)(= x 3003)) 4003
	(ite (and (= d Down)(= x 3004)) 4004
	(ite (and (= d Down)(= x 3005)) 4005
	(ite (and (= d Down)(= x 3006)) 4006
	(ite (and (= d Down)(= x 3007)) 4007
	(ite (and (= d Down)(= x 3008)) 4008
	(ite (and (= d Down)(= x 3009)) 4009
	(ite (and (= d Down)(= x 30010)) 40010
	(ite (and (= d Down)(= x 30011)) 40011
	(ite (and (= d Down)(= x 30012)) 40012
	(ite (and (= d Down)(= x 4000)) 5000
	(ite (and (= d Down)(= x 4001)) 5001
	(ite (and (= d Down)(= x 4002)) 5002
	(ite (and (= d Down)(= x 4003)) 5003
	(ite (and (= d Down)(= x 4004)) 5004
	(ite (and (= d Down)(= x 4005)) 5005
	(ite (and (= d Down)(= x 4006)) 5006
	(ite (and (= d Down)(= x 4007)) 5007
	(ite (and (= d Down)(= x 4008)) 5008
	(ite (and (= d Down)(= x 4009)) 5009
	(ite (and (= d Down)(= x 40010)) 50010
	(ite (and (= d Down)(= x 40011)) 50011
	(ite (and (= d Down)(= x 40012)) 50012
	(ite (and (= d Down)(= x 5000)) 6000
	(ite (and (= d Down)(= x 5001)) 6001
	(ite (and (= d Down)(= x 5002)) 6002
	(ite (and (= d Down)(= x 5003)) 6003
	(ite (and (= d Down)(= x 5004)) 6004
	(ite (and (= d Down)(= x 5005)) 6005
	(ite (and (= d Down)(= x 5006)) 6006
	(ite (and (= d Down)(= x 5007)) 6007
	(ite (and (= d Down)(= x 5008)) 6008
	(ite (and (= d Down)(= x 5009)) 6009
	(ite (and (= d Down)(= x 50010)) 60010
	(ite (and (= d Down)(= x 50011)) 60011
	(ite (and (= d Down)(= x 50012)) 60012
	(ite (and (= d Down)(= x 6000)) 7000
	(ite (and (= d Down)(= x 6001)) 7001
	(ite (and (= d Down)(= x 6002)) 7002
	(ite (and (= d Down)(= x 6003)) 7003
	(ite (and (= d Down)(= x 6004)) 7004
	(ite (and (= d Down)(= x 6005)) 7005
	(ite (and (= d Down)(= x 6006)) 7006
	(ite (and (= d Down)(= x 6007)) 7007
	(ite (and (= d Down)(= x 6008)) 7008
	(ite (and (= d Down)(= x 6009)) 7009
	(ite (and (= d Down)(= x 60010)) 70010
	(ite (and (= d Down)(= x 60011)) 70011
	(ite (and (= d Down)(= x 60012)) 70012
	(ite (and (= d Down)(= x 7000)) 8000
	(ite (and (= d Down)(= x 7001)) 8001
	(ite (and (= d Down)(= x 7002)) 8002
	(ite (and (= d Down)(= x 7003)) 8003
	(ite (and (= d Down)(= x 7004)) 8004
	(ite (and (= d Down)(= x 7005)) 8005
	(ite (and (= d Down)(= x 7006)) 8006
	(ite (and (= d Down)(= x 7007)) 8007
	(ite (and (= d Down)(= x 7008)) 8008
	(ite (and (= d Down)(= x 7009)) 8009
	(ite (and (= d Down)(= x 70010)) 80010
	(ite (and (= d Down)(= x 70011)) 80011
	(ite (and (= d Down)(= x 70012)) 80012
	(ite (and (= d Down)(= x 8000)) 9000
	(ite (and (= d Down)(= x 8001)) 9001
	(ite (and (= d Down)(= x 8002)) 9002
	(ite (and (= d Down)(= x 8003)) 9003
	(ite (and (= d Down)(= x 8004)) 9004
	(ite (and (= d Down)(= x 8005)) 9005
	(ite (and (= d Down)(= x 8006)) 9006
	(ite (and (= d Down)(= x 8007)) 9007
	(ite (and (= d Down)(= x 8008)) 9008
	(ite (and (= d Down)(= x 8009)) 9009
	(ite (and (= d Down)(= x 80010)) 90010
	(ite (and (= d Down)(= x 80011)) 90011
	(ite (and (= d Down)(= x 80012)) 90012
	(ite (and (= d Down)(= x 9000)) 10000
	(ite (and (= d Down)(= x 9001)) 10001
	(ite (and (= d Down)(= x 9002)) 10002
	(ite (and (= d Down)(= x 9003)) 10003
	(ite (and (= d Down)(= x 9004)) 10004
	(ite (and (= d Down)(= x 9005)) 10005
	(ite (and (= d Down)(= x 9006)) 10006
	(ite (and (= d Down)(= x 9007)) 10007
	(ite (and (= d Down)(= x 9008)) 10008
	(ite (and (= d Down)(= x 9009)) 10009
	(ite (and (= d Down)(= x 90010)) 100010
	(ite (and (= d Down)(= x 90011)) 100011
	(ite (and (= d Down)(= x 90012)) 100012
	(ite (and (= d Down)(= x 10000)) 11000
	(ite (and (= d Down)(= x 10001)) 11001
	(ite (and (= d Down)(= x 10002)) 11002
	(ite (and (= d Down)(= x 10003)) 11003
	(ite (and (= d Down)(= x 10004)) 11004
	(ite (and (= d Down)(= x 10005)) 11005
	(ite (and (= d Down)(= x 10006)) 11006
	(ite (and (= d Down)(= x 10007)) 11007
	(ite (and (= d Down)(= x 10008)) 11008
	(ite (and (= d Down)(= x 10009)) 11009
	(ite (and (= d Down)(= x 100010)) 110010
	(ite (and (= d Down)(= x 100011)) 110011
	(ite (and (= d Down)(= x 100012)) 110012
	(ite (and (= d Down)(= x 11000)) 12000
	(ite (and (= d Down)(= x 11001)) 12001
	(ite (and (= d Down)(= x 11002)) 12002
	(ite (and (= d Down)(= x 11003)) 12003
	(ite (and (= d Down)(= x 11004)) 12004
	(ite (and (= d Down)(= x 11005)) 12005
	(ite (and (= d Down)(= x 11006)) 12006
	(ite (and (= d Down)(= x 11007)) 12007
	(ite (and (= d Down)(= x 11008)) 12008
	(ite (and (= d Down)(= x 11009)) 12009
	(ite (and (= d Down)(= x 110010)) 120010
	(ite (and (= d Down)(= x 110011)) 120011
	(ite (and (= d Down)(= x 110012)) 120012
	(ite (and (= d Down)(= x 12000)) (- 1)
	(ite (and (= d Down)(= x 12001)) (- 1)
	(ite (and (= d Down)(= x 12002)) (- 1)
	(ite (and (= d Down)(= x 12003)) (- 1)
	(ite (and (= d Down)(= x 12004)) (- 1)
	(ite (and (= d Down)(= x 12005)) (- 1)
	(ite (and (= d Down)(= x 12006)) (- 1)
	(ite (and (= d Down)(= x 12007)) (- 1)
	(ite (and (= d Down)(= x 12008)) (- 1)
	(ite (and (= d Down)(= x 12009)) (- 1)
	(ite (and (= d Down)(= x 120010)) (- 1)
	(ite (and (= d Down)(= x 120011)) (- 1)
	(ite (and (= d Down)(= x 120012)) (- 1)
	(ite (and (= d Up)(= x 0000)) (- 1)
	(ite (and (= d Up)(= x 0001)) (- 1)
	(ite (and (= d Up)(= x 0002)) (- 1)
	(ite (and (= d Up)(= x 0003)) (- 1)
	(ite (and (= d Up)(= x 0004)) (- 1)
	(ite (and (= d Up)(= x 0005)) (- 1)
	(ite (and (= d Up)(= x 0006)) (- 1)
	(ite (and (= d Up)(= x 0007)) (- 1)
	(ite (and (= d Up)(= x 0008)) (- 1)
	(ite (and (= d Up)(= x 0009)) (- 1)
	(ite (and (= d Up)(= x 00010)) (- 1)
	(ite (and (= d Up)(= x 00011)) (- 1)
	(ite (and (= d Up)(= x 00012)) (- 1)
	(ite (and (= d Up)(= x 1000)) 0000
	(ite (and (= d Up)(= x 1001)) 0001
	(ite (and (= d Up)(= x 1002)) 0002
	(ite (and (= d Up)(= x 1003)) 0003
	(ite (and (= d Up)(= x 1004)) 0004
	(ite (and (= d Up)(= x 1005)) 0005
	(ite (and (= d Up)(= x 1006)) 0006
	(ite (and (= d Up)(= x 1007)) 0007
	(ite (and (= d Up)(= x 1008)) 0008
	(ite (and (= d Up)(= x 1009)) 0009
	(ite (and (= d Up)(= x 10010)) 00010
	(ite (and (= d Up)(= x 10011)) 00011
	(ite (and (= d Up)(= x 10012)) 00012
	(ite (and (= d Up)(= x 2000)) 1000
	(ite (and (= d Up)(= x 2001)) 1001
	(ite (and (= d Up)(= x 2002)) 1002
	(ite (and (= d Up)(= x 2003)) 1003
	(ite (and (= d Up)(= x 2004)) 1004
	(ite (and (= d Up)(= x 2005)) 1005
	(ite (and (= d Up)(= x 2006)) 1006
	(ite (and (= d Up)(= x 2007)) 1007
	(ite (and (= d Up)(= x 2008)) 1008
	(ite (and (= d Up)(= x 2009)) 1009
	(ite (and (= d Up)(= x 20010)) 10010
	(ite (and (= d Up)(= x 20011)) 10011
	(ite (and (= d Up)(= x 20012)) 10012
	(ite (and (= d Up)(= x 3000)) 2000
	(ite (and (= d Up)(= x 3001)) 2001
	(ite (and (= d Up)(= x 3002)) 2002
	(ite (and (= d Up)(= x 3003)) 2003
	(ite (and (= d Up)(= x 3004)) 2004
	(ite (and (= d Up)(= x 3005)) 2005
	(ite (and (= d Up)(= x 3006)) 2006
	(ite (and (= d Up)(= x 3007)) 2007
	(ite (and (= d Up)(= x 3008)) 2008
	(ite (and (= d Up)(= x 3009)) 2009
	(ite (and (= d Up)(= x 30010)) 20010
	(ite (and (= d Up)(= x 30011)) 20011
	(ite (and (= d Up)(= x 30012)) 20012
	(ite (and (= d Up)(= x 4000)) 3000
	(ite (and (= d Up)(= x 4001)) 3001
	(ite (and (= d Up)(= x 4002)) 3002
	(ite (and (= d Up)(= x 4003)) 3003
	(ite (and (= d Up)(= x 4004)) 3004
	(ite (and (= d Up)(= x 4005)) 3005
	(ite (and (= d Up)(= x 4006)) 3006
	(ite (and (= d Up)(= x 4007)) 3007
	(ite (and (= d Up)(= x 4008)) 3008
	(ite (and (= d Up)(= x 4009)) 3009
	(ite (and (= d Up)(= x 40010)) 30010
	(ite (and (= d Up)(= x 40011)) 30011
	(ite (and (= d Up)(= x 40012)) 30012
	(ite (and (= d Up)(= x 5000)) 4000
	(ite (and (= d Up)(= x 5001)) 4001
	(ite (and (= d Up)(= x 5002)) 4002
	(ite (and (= d Up)(= x 5003)) 4003
	(ite (and (= d Up)(= x 5004)) 4004
	(ite (and (= d Up)(= x 5005)) 4005
	(ite (and (= d Up)(= x 5006)) 4006
	(ite (and (= d Up)(= x 5007)) 4007
	(ite (and (= d Up)(= x 5008)) 4008
	(ite (and (= d Up)(= x 5009)) 4009
	(ite (and (= d Up)(= x 50010)) 40010
	(ite (and (= d Up)(= x 50011)) 40011
	(ite (and (= d Up)(= x 50012)) 40012
	(ite (and (= d Up)(= x 6000)) 5000
	(ite (and (= d Up)(= x 6001)) 5001
	(ite (and (= d Up)(= x 6002)) 5002
	(ite (and (= d Up)(= x 6003)) 5003
	(ite (and (= d Up)(= x 6004)) 5004
	(ite (and (= d Up)(= x 6005)) 5005
	(ite (and (= d Up)(= x 6006)) 5006
	(ite (and (= d Up)(= x 6007)) 5007
	(ite (and (= d Up)(= x 6008)) 5008
	(ite (and (= d Up)(= x 6009)) 5009
	(ite (and (= d Up)(= x 60010)) 50010
	(ite (and (= d Up)(= x 60011)) 50011
	(ite (and (= d Up)(= x 60012)) 50012
	(ite (and (= d Up)(= x 7000)) 6000
	(ite (and (= d Up)(= x 7001)) 6001
	(ite (and (= d Up)(= x 7002)) 6002
	(ite (and (= d Up)(= x 7003)) 6003
	(ite (and (= d Up)(= x 7004)) 6004
	(ite (and (= d Up)(= x 7005)) 6005
	(ite (and (= d Up)(= x 7006)) 6006
	(ite (and (= d Up)(= x 7007)) 6007
	(ite (and (= d Up)(= x 7008)) 6008
	(ite (and (= d Up)(= x 7009)) 6009
	(ite (and (= d Up)(= x 70010)) 60010
	(ite (and (= d Up)(= x 70011)) 60011
	(ite (and (= d Up)(= x 70012)) 60012
	(ite (and (= d Up)(= x 8000)) 7000
	(ite (and (= d Up)(= x 8001)) 7001
	(ite (and (= d Up)(= x 8002)) 7002
	(ite (and (= d Up)(= x 8003)) 7003
	(ite (and (= d Up)(= x 8004)) 7004
	(ite (and (= d Up)(= x 8005)) 7005
	(ite (and (= d Up)(= x 8006)) 7006
	(ite (and (= d Up)(= x 8007)) 7007
	(ite (and (= d Up)(= x 8008)) 7008
	(ite (and (= d Up)(= x 8009)) 7009
	(ite (and (= d Up)(= x 80010)) 70010
	(ite (and (= d Up)(= x 80011)) 70011
	(ite (and (= d Up)(= x 80012)) 70012
	(ite (and (= d Up)(= x 9000)) 8000
	(ite (and (= d Up)(= x 9001)) 8001
	(ite (and (= d Up)(= x 9002)) 8002
	(ite (and (= d Up)(= x 9003)) 8003
	(ite (and (= d Up)(= x 9004)) 8004
	(ite (and (= d Up)(= x 9005)) 8005
	(ite (and (= d Up)(= x 9006)) 8006
	(ite (and (= d Up)(= x 9007)) 8007
	(ite (and (= d Up)(= x 9008)) 8008
	(ite (and (= d Up)(= x 9009)) 8009
	(ite (and (= d Up)(= x 90010)) 80010
	(ite (and (= d Up)(= x 90011)) 80011
	(ite (and (= d Up)(= x 90012)) 80012
	(ite (and (= d Up)(= x 10000)) 9000
	(ite (and (= d Up)(= x 10001)) 9001
	(ite (and (= d Up)(= x 10002)) 9002
	(ite (and (= d Up)(= x 10003)) 9003
	(ite (and (= d Up)(= x 10004)) 9004
	(ite (and (= d Up)(= x 10005)) 9005
	(ite (and (= d Up)(= x 10006)) 9006
	(ite (and (= d Up)(= x 10007)) 9007
	(ite (and (= d Up)(= x 10008)) 9008
	(ite (and (= d Up)(= x 10009)) 9009
	(ite (and (= d Up)(= x 100010)) 90010
	(ite (and (= d Up)(= x 100011)) 90011
	(ite (and (= d Up)(= x 100012)) 90012
	(ite (and (= d Up)(= x 11000)) 10000
	(ite (and (= d Up)(= x 11001)) 10001
	(ite (and (= d Up)(= x 11002)) 10002
	(ite (and (= d Up)(= x 11003)) 10003
	(ite (and (= d Up)(= x 11004)) 10004
	(ite (and (= d Up)(= x 11005)) 10005
	(ite (and (= d Up)(= x 11006)) 10006
	(ite (and (= d Up)(= x 11007)) 10007
	(ite (and (= d Up)(= x 11008)) 10008
	(ite (and (= d Up)(= x 11009)) 10009
	(ite (and (= d Up)(= x 110010)) 100010
	(ite (and (= d Up)(= x 110011)) 100011
	(ite (and (= d Up)(= x 110012)) 100012
	(ite (and (= d Up)(= x 12000)) 11000
	(ite (and (= d Up)(= x 12001)) 11001
	(ite (and (= d Up)(= x 12002)) 11002
	(ite (and (= d Up)(= x 12003)) 11003
	(ite (and (= d Up)(= x 12004)) 11004
	(ite (and (= d Up)(= x 12005)) 11005
	(ite (and (= d Up)(= x 12006)) 11006
	(ite (and (= d Up)(= x 12007)) 11007
	(ite (and (= d Up)(= x 12008)) 11008
	(ite (and (= d Up)(= x 12009)) 11009
	(ite (and (= d Up)(= x 120010)) 110010
	(ite (and (= d Up)(= x 120011)) 110011
	(ite (and (= d Up)(= x 120012)) 110012
	(- 1))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(declare-const position_0 Int)
(assert (= position_0 0000))
(declare-const move_1 Direction)
(declare-const position_1 Int)
(assert (= position_1 (move position_0 move_1)))
(declare-const move_2 Direction)
(declare-const position_2 Int)
(assert (= position_2 (move position_1 move_2)))
(declare-const move_3 Direction)
(declare-const position_3 Int)
(assert (= position_3 (move position_2 move_3)))
(declare-const move_4 Direction)
(declare-const position_4 Int)
(assert (= position_4 (move position_3 move_4)))
(assert (not (= move_4 move_3 move_2 move_1)))
(declare-const move_5 Direction)
(declare-const position_5 Int)
(assert (= position_5 (move position_4 move_5)))
(assert (not (= move_5 move_4 move_3 move_2)))
(declare-const move_6 Direction)
(declare-const position_6 Int)
(assert (= position_6 (move position_5 move_6)))
(assert (not (= move_6 move_5 move_4 move_3)))
(declare-const move_7 Direction)
(declare-const position_7 Int)
(assert (= position_7 (move position_6 move_7)))
(assert (not (= move_7 move_6 move_5 move_4)))
(declare-const move_8 Direction)
(declare-const position_8 Int)
(assert (= position_8 (move position_7 move_8)))
(assert (not (= move_8 move_7 move_6 move_5)))
(declare-const move_9 Direction)
(declare-const position_9 Int)
(assert (= position_9 (move position_8 move_9)))
(assert (not (= move_9 move_8 move_7 move_6)))
(declare-const move_10 Direction)
(declare-const position_10 Int)
(assert (= position_10 (move position_9 move_10)))
(assert (not (= move_10 move_9 move_8 move_7)))
(declare-const move_11 Direction)
(declare-const position_11 Int)
(assert (= position_11 (move position_10 move_11)))
(assert (not (= move_11 move_10 move_9 move_8)))
(declare-const move_12 Direction)
(declare-const position_12 Int)
(assert (= position_12 (move position_11 move_12)))
(assert (not (= move_12 move_11 move_10 move_9)))
(declare-const move_13 Direction)
(declare-const position_13 Int)
(assert (= position_13 (move position_12 move_13)))
(assert (not (= move_13 move_12 move_11 move_10)))
(declare-const move_14 Direction)
(declare-const position_14 Int)
(assert (= position_14 (move position_13 move_14)))
(assert (not (= move_14 move_13 move_12 move_11)))
(declare-const move_15 Direction)
(declare-const position_15 Int)
(assert (= position_15 (move position_14 move_15)))
(assert (not (= move_15 move_14 move_13 move_12)))
(declare-const move_16 Direction)
(declare-const position_16 Int)
(assert (= position_16 (move position_15 move_16)))
(assert (not (= move_16 move_15 move_14 move_13)))
(declare-const move_17 Direction)
(declare-const position_17 Int)
(assert (= position_17 (move position_16 move_17)))
(assert (not (= move_17 move_16 move_15 move_14)))
(declare-const move_18 Direction)
(declare-const position_18 Int)
(assert (= position_18 (move position_17 move_18)))
(assert (not (= move_18 move_17 move_16 move_15)))
(declare-const move_19 Direction)
(declare-const position_19 Int)
(assert (= position_19 (move position_18 move_19)))
(assert (not (= move_19 move_18 move_17 move_16)))
(declare-const move_20 Direction)
(declare-const position_20 Int)
(assert (= position_20 (move position_19 move_20)))
(assert (not (= move_20 move_19 move_18 move_17)))
(declare-const move_21 Direction)
(declare-const position_21 Int)
(assert (= position_21 (move position_20 move_21)))
(assert (not (= move_21 move_20 move_19 move_18)))
(declare-const move_22 Direction)
(declare-const position_22 Int)
(assert (= position_22 (move position_21 move_22)))
(assert (not (= move_22 move_21 move_20 move_19)))
(declare-const move_23 Direction)
(declare-const position_23 Int)
(assert (= position_23 (move position_22 move_23)))
(assert (not (= move_23 move_22 move_21 move_20)))
(declare-const move_24 Direction)
(declare-const position_24 Int)
(assert (= position_24 (move position_23 move_24)))
(assert (not (= move_24 move_23 move_22 move_21)))
(declare-const move_25 Direction)
(declare-const position_25 Int)
(assert (= position_25 (move position_24 move_25)))
(assert (not (= move_25 move_24 move_23 move_22)))
(declare-const move_26 Direction)
(declare-const position_26 Int)
(assert (= position_26 (move position_25 move_26)))
(assert (not (= move_26 move_25 move_24 move_23)))
(declare-const move_27 Direction)
(declare-const position_27 Int)
(assert (= position_27 (move position_26 move_27)))
(assert (not (= move_27 move_26 move_25 move_24)))
(declare-const move_28 Direction)
(declare-const position_28 Int)
(assert (= position_28 (move position_27 move_28)))
(assert (not (= move_28 move_27 move_26 move_25)))
(declare-const move_29 Direction)
(declare-const position_29 Int)
(assert (= position_29 (move position_28 move_29)))
(assert (not (= move_29 move_28 move_27 move_26)))
(declare-const move_30 Direction)
(declare-const position_30 Int)
(assert (= position_30 (move position_29 move_30)))
(assert (not (= move_30 move_29 move_28 move_27)))
(declare-const move_31 Direction)
(declare-const position_31 Int)
(assert (= position_31 (move position_30 move_31)))
(assert (not (= move_31 move_30 move_29 move_28)))
(declare-const move_32 Direction)
(declare-const position_32 Int)
(assert (= position_32 (move position_31 move_32)))
(assert (not (= move_32 move_31 move_30 move_29)))
(declare-const move_33 Direction)
(declare-const position_33 Int)
(assert (= position_33 (move position_32 move_33)))
(assert (not (= move_33 move_32 move_31 move_30)))
(declare-const move_34 Direction)
(declare-const position_34 Int)
(assert (= position_34 (move position_33 move_34)))
(assert (not (= move_34 move_33 move_32 move_31)))
(declare-const move_35 Direction)
(declare-const position_35 Int)
(assert (= position_35 (move position_34 move_35)))
(assert (not (= move_35 move_34 move_33 move_32)))
(declare-const move_36 Direction)
(declare-const position_36 Int)
(assert (= position_36 (move position_35 move_36)))
(assert (not (= move_36 move_35 move_34 move_33)))
(declare-const move_37 Direction)
(declare-const position_37 Int)
(assert (= position_37 (move position_36 move_37)))
(assert (not (= move_37 move_36 move_35 move_34)))
(declare-const move_38 Direction)
(declare-const position_38 Int)
(assert (= position_38 (move position_37 move_38)))
(assert (not (= move_38 move_37 move_36 move_35)))
(declare-const move_39 Direction)
(declare-const position_39 Int)
(assert (= position_39 (move position_38 move_39)))
(assert (not (= move_39 move_38 move_37 move_36)))
(declare-const move_40 Direction)
(declare-const position_40 Int)
(assert (= position_40 (move position_39 move_40)))
(assert (not (= move_40 move_39 move_38 move_37)))
(assert (= position_40 99900999))
(assert (<= (+ (get_weight position_0) (+ (get_weight position_1) (+ (get_weight position_2) (+ (get_weight position_3) (+ (get_weight position_4) (+ (get_weight position_5) (+ (get_weight position_6) (+ (get_weight position_7) (+ (get_weight position_8) (+ (get_weight position_9) (+ (get_weight position_10) (+ (get_weight position_11) (+ (get_weight position_12) (+ (get_weight position_13) (+ (get_weight position_14) (+ (get_weight position_15) (+ (get_weight position_16) (+ (get_weight position_17) (+ (get_weight position_18) (+ (get_weight position_19) (+ (get_weight position_20) (+ (get_weight position_21) (+ (get_weight position_22) (+ (get_weight position_23) (+ (get_weight position_24) (+ (get_weight position_25) (+ (get_weight position_26) (+ (get_weight position_27) (+ (get_weight position_28) (+ (get_weight position_29) (+ (get_weight position_30) (+ (get_weight position_31) (+ (get_weight position_32) (+ (get_weight position_33) (+ (get_weight position_34) (+ (get_weight position_35) (+ (get_weight position_36) (+ (get_weight position_37) (+ (get_weight position_38) (+ (get_weight position_39) (+ (get_weight position_40) 0))))))))))))))))))))))))))))))))))))))))) 102))
(check-sat)
