CREATE TABLE facciones (
  id INTEGER,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE personas(
 id INTEGER,
 nombre VARCHAR(45) NOT NULL,
 apellidos VARCHAR(45) NOT NULL,
 fecha_nacimiento DATE NOT NULL,
 infectado BOOL NOT NULL,
 conyugue INTEGER,
 FOREIGN KEY (conyugue) REFERENCES personas,
 PRIMARY KEY (id)
);


CREATE TABLE persona_pertenece_faccion (
 id_persona INTEGER,
 id_faccion INTEGER,
 PRIMARY KEY (id_faccion, id_persona),
 FOREIGN KEY (id_persona) REFERENCES personas(id),
 FOREIGN KEY (id_faccion) REFERENCES facciones(id)
);

CREATE TABLE cuentas_bancarias (
 id INTEGER PRIMARY KEY,
 tipo_de_cuenta VARCHAR(45) NOT NULL,
 banco VARCHAR(45) NOT NULL,
 saldo INTEGER NOT NULL,
 id_persona INTEGER,
 FOREIGN KEY (id_persona) REFERENCES personas (id)
);

CREATE TABLE trabajos (
 id INTEGER PRIMARY KEY,
 nombre VARCHAR(45) NOT NULL,
 descripcion VARCHAR(45) NOT NULL,
 sueldo INTEGER NOT NULL
);


CREATE TABLE persona_tiene_trabajo (
 id_persona INTEGER,
 id_trabajo INTEGER,
 estado BOOL NOT NULL,
 ultima_vez_realizado TIMESTAMP NOT NULL,
 PRIMARY KEY (id_persona, id_trabajo),
 FOREIGN KEY (id_persona) REFERENCES personas (id), 
 FOREIGN KEY (id_trabajo) REFERENCES trabajos (id)
);


"Consulta 1"
SELECT 
  personas.id, personas.nombre, personas.apellidos
FROM 
  personas INNER JOIN persona_pertenece_faccion 
ON 
  personas.id = persona_pertenece_faccion.id_persona INNER JOIN facciones 
ON 
  persona_pertenece_faccion.id_faccion = facciones.id
WHERE 
  facciones.nombre = 'FEDRA';

"Consulta 2"
SELECT
  count(Personas.id)
FROM
  Personas
WHERE 
  Personas.fecha_nacimiento < '2019-12-01'

"Consulta 3"
SELECT
  Personas.id, Personas.nombre, Personas.apellidos, cuentas_bancarias.saldo 
FROM
  Personas INNER JOIN cuentas_bancarias
ON
  Personas.id = cuentas_bancarias.id_persona
limit 20



"Consulta 4"
SELECT 
  facciones.nombre, COUNT(persona_tiene_trabajo.id_persona) as cantidad
FROM 
  facciones 
JOIN 
  persona_pertenece_faccion 
ON 
  facciones.id = persona_pertenece_faccion.id_faccion
JOIN 
  persona_tiene_trabajo 
ON 
  persona_tiene_trabajo.id_persona = persona_pertenece_faccion.id_persona
WHERE 
  persona_tiene_trabajo.estado = true	
GROUP BY 
  facciones.nombre;
  
"Consulta 5"

SELECT
  facciones.nombre, COUNT(personas.infectado) AS cantidad_infectados
FROM
  facciones
JOIN
  persona_pertenece_faccion
ON
  facciones.id = persona_pertenece_faccion.id_faccion
JOIN
  personas
ON
  persona_pertenece_faccion.id_persona = personas.id
WHERE
  personas.infectado = true
GROUP BY 
	facciones.nombre;

"Consulta 6"
 
SELECT
  facciones.nombre, cout(trabajos.nombre), trabajos.nombre
FROM
  facciones
JOIN 
  persona_pertenece_faccion
ON
  facciones.id = persona_pertenece_faccion.id_faccion
JOIN
  personas
ON
  persona_pertenece_faccion.id_persona = personas.id
JOIN
  persona_tiene_trabajo
ON 
  persona_tiene_trabajo.id_persona = personas.id
JOIN
  trabajos
ON
  persona_tiene_trabajo.id_persona = trabajos.id
GROUP BY
  facciones.nombre;


