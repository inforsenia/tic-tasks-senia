# TIC Task - Senia 

Tareas TIC del IES la Senia.

## Introducción

Dentro del IES aparecen una serie de tareas que pueden ser resueltas utilizando herramientas 
desarrolladas usando Software Libre, y otras configuraciones que pueden ser de utilidad.

[ Aviso a navegantes] : Muchas de las cosas que encontrarás aquí están sin documentar, pero 
los lenguajes de programación elegidos permiten comprender el código y su propósito.


## Configuración de Quotas en el Aula 5

En esta carpeta podrás encontrar la estructura de directorios, ficheros, scripts y crons necesaria para
poner en marcha el mecanismo de `quotas` en el Aula 5.

* ![senia-quotas-aula5](./senia-aula5)

### Generación del tar.gz

Para generar el tar.gz:

```bash
cd senia-aula5
tar ../senia-aula5.tar.gz *
```

### Instalación en equipos

Una vez tenemos el fichero comprimido en el equipo:

```bash
sudo su
cd /
# Importante hacer esto desde /
tar xvzf RUTA_AL_senia-aula5.tar.gz .
```

## Configuración para los mirrors

* ![ Mirror de Ubuntu y LliureX](./mirror/)
