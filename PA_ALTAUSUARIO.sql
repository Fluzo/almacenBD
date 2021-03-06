CREATE PROCEDURE PA_ALTA_USUARIO
(
	@USUARIO VARCHAR(20),
	@PASSWORD VARCHAR(50),
	@EMAIL VARCHAR(100),
	@ID_PERFIL INT,

	@MENSAJE VARCHAR(2000) OUTPUT,
	@RETCODE INT OUTPUT
)
AS 
BEGIN TRY 


	IF ISNULL(@USUARIO,'') = ''
	BEGIN
		SET @MENSAJE = 'Falta dato Usuario'
		SET @RETCODE = 1
		RETURN
	END

	IF ISNULL(@PASSWORD,'') = ''
	BEGIN
		SET @MENSAJE = 'Falta dato Contraseña'
		SET @RETCODE = 1
		RETURN
	END

	IF ISNULL(@EMAIL,'') = ''
	BEGIN
		SET @MENSAJE = 'Falta dato email'
		SET @RETCODE = 1
		RETURN
	END



	IF ISNULL(@ID_PERFIL,'') = ''
	BEGIN
		SET @MENSAJE = 'Falta id perfil'
		SET @RETCODE = 1
		RETURN
	END

	IF NOT EXISTS (SELECT * FROM USUARIOS WHERE USUARIO = @USUARIO)
	BEGIN
		
		INSERT INTO USUARIOS
		(
			USUARIO,
			EMAIL,
			[PASSWORD],
			ID_PERFIL,
			ACTIVO
		)
		VALUES
		(
			@USUARIO,
			@EMAIL,
			@PASSWORD,
			@ID_PERFIL,
			1
		)

		SET @RETCODE = 0
		SET @MENSAJE = 'Usuario creado correctamente'
	END
	ELSE
	BEGIN
		SET @MENSAJE = 'El usuario ya existe'
		SET @RETCODE = 1
		RETURN
	END
	
END TRY

BEGIN CATCH
	SET @RETCODE = -1
END CATCH

