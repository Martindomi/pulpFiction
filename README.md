# pulpFiction
TP Logico - PdeP

Pulp Fiction

Parte 1: Relaciones entre individuos. Recursividad. Negación. 

Tarantino, un poco cansado después de largas horas de filmación de su clásico noventoso Pulp Fiction, decidió escribir un programa Prolog para entender mejor las relaciones entre sus personajes. 

Para ello nos entregó la siguiente base de conocimientos sobre sus personajes, parejas y actividades:

%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

Todos los predicados deben ser inversibles en todos sus argumentos, a menos de que se especifique lo contrario.
Salen juntos
saleCon/2: relaciona dos personas que están saliendo porque son pareja, independientemente de cómo esté definido en el predicado pareja/2.

Ejemplo: 
?- saleCon(Quien, Cual).
Quien = marsellus,
Cual = mia ;
Quien = pumkin,
Cual = honeyBunny ;
Quien = mia, % Están al revés que antes
Cual = marsellus 
... 

La cláusula ¿es recursiva? En caso afirmativo separe caso base y caso recursivo.
Más parejas
Necesitamos agregar la siguiente Información
Bernardo es pareja de Bianca y de Charo
No se sabe si Bianca es pareja de Demóstenes
Nuevos trabajadores
Necesitamos agregar más información
Bernardo trabaja para cualquiera que trabaje para marsellus (salvo para jules) 
George trabaja para todos los que salen con Bernardo

Ejemplo: 
?- trabajaPara(Quien, bernardo).
Quien = vincent ;

?- trabajaPara(Empleador, george).
Empleador = bianca ;
Empleador = charo.
Fidelidad
Realizar el predicado esFiel/1 sabiendo que una persona es fiel cuando sale con una única persona. 

?- esFiel(Personaje).
Personaje = marsellus ;
Personaje = pumkin ;
Personaje = mia ;
Personaje = honeyBunny ;
Personaje = bianca ;
Personaje = charo.

Atención: not es un predicado de aridad 1, no se puede utilizar así
not(5 = 6, 7 = 9) porque aquí not tendría aridad 2
en cambio sí se puede utilizar 
?-  not((5 = 6, 7 = 9)).
true
Acatar órdenes
Realizar el predicado acataOrden/2 que relaciona dos personas. Alguien acata la orden de otra persona si trabaja para esa persona directa o indirectamente (porque trabaja para otro que a su vez trabaja para esa persona, y así sucesivamente).

Ejemplo:
?- acataOrden(marsellus, Empleado).
Empleado = vincent ;
Empleado = jules ;
Empleado = winston ;
Empleado = bernardo ;
Empleado = bernardo ;
false.

La cláusula ¿es recursiva? En caso afirmativo separe caso base y caso recursivo.




Parte 2: Polimorfismo. Functores. Aritmética. Predicados de orden superior.

Agregamos la siguiente información a nuestra base de conocimientos
% Información base
% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

También tenemos información de los encargos que le hacen los jefes a sus empleados, codificada en la base de la siguiente forma: 
% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

Por último contamos con la información de quién es amigo de quién:
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

Personajes peligrosos

esPeligroso/1. Nos dice si un personaje es peligroso. Eso ocurre cuando:
realiza alguna actividad peligrosa: ser matón, o robar licorerías. 
tiene un jefe peligroso

?- esPeligroso(Quien).
Quien = vincent ;    % maton
Quien = jules ;      % maton
Quien = pumkin ;     % roba licorerías
Quien = honeyBunny ; % roba licorerías
Quien = bernardo ;   % tiene como jefe a Vincent, que como vemos es peligroso
false.

San Cayetano

Se considera "San Cayetano" a quien a todos los que tiene cerca les da algún encargo (y tiene al menos a alguien cerca).
Alguien tiene cerca a otro personaje si son amigos o uno trabaja para el otro. 
Hacer el predicado sanCayetano/1

?- sanCayetano(Quien).
Quien = bernardo ;
Quien = bernardo ;
false.

Bernardo es San Cayetano, porque tiene cerca tanto a Winston como a Vincent (sus jefes), y les pide que hagan cosas (¡Qué atrevido!).

Nivel de Respeto

Realizar el predicado nivelRespeto/2 que relaciona a un personaje con su nivel de respeto.
El nivel de respeto se calcula como:
Para las actrices, la décima parte de su cantidad de peliculas.
Para los mafiosos que resuelven problemas es 10, mientras que para los capos asciende a 20.
Para Vincent es exactamente 15.
Para el resto no se cuenta con un nivel de respeto.

?- nivelRespeto(winston,Nivel).
Nivel = 10
10 por resolver problemas 

?- nivelRespeto(marsellus,Nivel).
Nivel = 20
por ser capo de la mafia

?- nivelRespeto(mia,Nivel).
Nivel = 0.1
Actua solo en una pelicula

?- nivelRespeto(vincent,Nivel).
Nivel = 15

Personajes respetables
Asumiendo que ya se sabe calcular el nivel de respeto de cualquier personaje, se quiere analizar la composición de personajes respetables de la película. Un personaje es respetable si su nivel de respeto es mayor a 9.
Se quiere averiguar la cantidad de personajes respetables y no respetables.

? respetabilidad(Respetables,NoRespetables).
Respetables = 3
NoRespetables = 9

Más atareado

Se quiere averiguar cual es el personaje más atareado, que es quien más encargos tenga.
Para ello es necesario definir también un predicado cantidadEncargos/2 que relaciona un personaje con la cantidad de encargos que le hicieron.
Como requisito, se debe utilizar forall/2 en la resolución.

?- masAtareado(Quien).
Quien = winston

Porque tiene 4 encargos, mientras que vincent tiene 3 y el vendedor sólo 1.


