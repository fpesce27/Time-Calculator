def convertir(start):
    hora = start.split(":")
    hora[0] = int(hora[0])
    hora[1] = float(hora[1])
    hora[1] = hora[1] / 100
    nueva = hora[0] + hora[1]
    return nueva

def add_time(start, duration, day = None):
    dias_semana = ["Monday", "Tuesday", "Wednesday", "Thusday", "Friday", "Saturday", "Sunday"]
    dias = 0

    start = start.split()
    convertida = convertir(start[0]) 

    convertida += convertir(duration)
    if (convertida % int(convertida)) * 10 > 6:
        convertida += 1
        convertida -= 0.6

    while convertida > 24:
        convertida -= 24
        dias += 1

    if dias == 1:
        text = " (next day)"
    elif dias > 1:
        text = f" ({dias} days later)"
    else:
        text = " "

    if convertida > 13:
        convertida -= 12
        start[1] = "PM"
    elif convertida > 0 and convertida < 1:
        convertida += 12
        start[1] = "AM"
    elif convertida >= 12 and convertida < 13:
        start[1] = "PM"
    else:
      start[1] = "AM"

    convertida = ":".join(str("{:.2f}".format(convertida)).split("."))
    if day == None:
        nueva_hora = f"{convertida} {start[1]} {text}"
    else:
        day = day.title()
        while dias > 6:
            dias -= 7
        for i in range(len(dias_semana)):
            if dias_semana[i] == day:
                dia_elegido = i
                break
        aux = dias + dia_elegido
        while aux > 6:
            aux -= 7
        day = dias_semana[aux]
        nueva_hora = f"{convertida} {start[1]}, {day}{text}"

    return nueva_hora

print(add_time("11:40 AM", "0:25"))
