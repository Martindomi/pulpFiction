/*-------------------------PARTE 1-------------------------*/

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
pareja(bernardo, bianca). %punto2
pareja(bernardo, charo). %punto2

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

trabajaPara(Empleador, bernardo):-	%punto2
	trabajaPara(marsellus, Empleador),
	Empleador \= jules.

trabajaPara(Empleador, george):- %punto2
	saleCon(bernardo, Empleador).


/*SaleCon, no es Recursiva*/

saleCon(UnaPersona, OtraPersona):-
	pareja(UnaPersona, OtraPersona).

saleCon(UnaPersona, OtraPersona):-
	pareja(OtraPersona, UnaPersona).	

	
/*fidelidad*/

noEsFiel(Personaje):-
	saleCon(Personaje,Alguien),
	saleCon(Personaje,Otro),
	Alguien \= Otro.

esFiel(Personaje):-
	saleCon(Personaje,_),
	not(noEsFiel(Personaje)).
	
/*acata orden, si es Recursiva*/

acataOrden(Empleador, Empleado):- %CasoBASE
	trabajaPara(Empleador, Empleado).
acataOrden(Empleador, Empleado):- %CasoRECURSIVO
	trabajaPara(Empleador, Intermedio),
	acataOrden(Intermedio,Empleado).
	
/*-------------------------PARTE 2-------------------------*/

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

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

/*personaje Peligrioso*/
	
esPersonajePeligroso(mafioso(maton)).
esPersonajePeligroso(ladron(ListaDeRobos)):-
	member(licorerias,ListaDeRobos).

esPeligroso(Nombre):-	
	personaje(Nombre, Ocupacion),
	esPersonajePeligroso(Ocupacion).	
esPeligroso(Nombre):-
	trabajaPara(Jefe,Nombre),
	esPeligroso(Jefe).

/* San Cayetano */

sonAmigos(Personaje, OtroPersonaje):-
	amigo(Personaje, OtroPersonaje).
sonAmigos(Personaje, OtroPersonaje):-
	amigo(OtroPersonaje, Personaje).
	
trabajanCerca(Personaje, OtroPersonaje):-
	trabajaPara(Personaje, OtroPersonaje).
trabajanCerca(Personaje, OtroPersonaje):-
	trabajaPara(OtroPersonaje, Personaje).

estanCerca(Personaje, OtroPersonaje):-
	sonAmigos(Personaje, OtroPersonaje).
estanCerca(Personaje, OtroPersonaje):-
	trabajanCerca(Personaje, OtroPersonaje).

sanCayetano(Personaje):-
	estanCerca(Personaje,_),
	forall(estanCerca(Personaje, OtroPersonaje), encargo(Personaje, OtroPersonaje, _)).
	
/* Nivel de Respeto */

cuantoRespeto(actriz(Peliculas), Respeto):-
	length(Peliculas,CantidadPeliculas),
	Respeto is CantidadPeliculas / 10.
cuantoRespeto(mafioso(resuelveProblemas), 10).
cuantoRespeto(mafioso(capo), 20).


nivelRespeto(Personaje,Respeto):-
	personaje(Personaje,Ocupacion),
	cuantoRespeto(Ocupacion,Respeto).
nivelRespeto(vincent, 15).

/* Personajes Respetables */

esRespetable(Personaje):-
	nivelRespeto(Personaje,Respeto),
	Respeto > 9.

respetabilidad(Respetables, NoRespetables):-
	findall(Personaje, esRespetable(Personaje), PersonajesRespetables),
	findall(Personaje, personaje(Personaje,_), TodosLosPersonajes),
	length(PersonajesRespetables, Respetables),
	length(TodosLosPersonajes, Todos),
	NoRespetables is Todos - Respetables.
	
/* Mas Atareado */

cantidadEncargos(Personaje,Cantidad):-
	personaje(Personaje,_),
	findall(Tarea, encargo(_, Personaje, Tarea), Tareas),
	length(Tareas,Cantidad).

masAtareado(Personaje):-	
	cantidadEncargos(Personaje,Cantidad),
	forall((cantidadEncargos(OtroPersonaje,CantidadOtro), Personaje \= OtroPersonaje),Cantidad > CantidadOtro).
	


	
	
