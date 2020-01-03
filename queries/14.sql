SELECT mail FROM socio WHERE socio.saldo_acumulado = ( SELECT MAX(saldo_acumulado) FROM socio )

