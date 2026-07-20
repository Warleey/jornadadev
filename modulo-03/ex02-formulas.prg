#define PI 3.14159

FUNCTION Main()

    // Variaveis de entrada
    LOCAL cEntrada  := ""
    LOCAL nRaio     := 0
    LOCAL nA        := 0
    LOCAL nB        := 0
    LOCAL nPeso     := 0
    LOCAL nAltura   := 0

    // Variaveis de resultado
    LOCAL nArea     := 0
    LOCAL nHip      := 0
    LOCAL nIMC      := 0

    // A) AREA DO CIRCULO 
    QOut("=== Area do Circulo ===")
    ACCEPT "Digite o raio: " TO cEntrada
    nRaio := Val(cEntrada)
    nArea := PI * (nRaio ^ 2)
    QOut("Area: " + Str(nArea, 10, 2))

    QOut("")

    //  B) HIPOTENUSA 
    QOut("=== Hipotenusa ===")
    ACCEPT "Digite o lado A: " TO cEntrada
    nA := Val(cEntrada)
    ACCEPT "Digite o lado B: " TO cEntrada
    nB := Val(cEntrada)
    nHip := Sqrt((nA ^ 2) + (nB ^ 2))
    QOut("Hipotenusa: " + Str(nHip, 10, 2))

    QOut("")

    // C) IMC 
    QOut("=== IMC ===")
    ACCEPT "Digite o peso (kg): " TO cEntrada
    nPeso := Val(cEntrada)
    ACCEPT "Digite a altura (m): " TO cEntrada
    nAltura := Val(cEntrada)
    nIMC := nPeso / (nAltura ^ 2)
    QOut("IMC: " + Str(nIMC, 10, 2))

RETURN NIL 