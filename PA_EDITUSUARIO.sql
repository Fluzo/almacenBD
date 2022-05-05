ALTER PROCEDURE PA_EDITAR_USUARIO
(
	@ID_USUARIO INT,
	@PASSWORD VARCHAR(50),
	@EMAIL VARCHAR(100),
	@ACTIVO BIT,
	@ID_PERFIL INT,

	@MENSAJE VARCHAR(2000) OUTPUT,
	@RETCODE INT OUTPUT
)
AS 
BEGIN TRY 

	IF ISNULL(@ID_USUARIO,'') = ''
	BEGIN
		SET @MENSAJE = 'Falta dato id usuario'
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

	IF EXISTS (SELECT * FROM USUARIOS WHERE ID_USUARIO = @ID_USUARIO)
	BEGIN
		
		UPDATE	USUARIOS 
		SET		EMAIL = @EMAIL, 
				PASSWORD = @PASSWORD, 
				ACTIVO = ISNULL(@ACTIVO,0), 
				ID_PERFIL = @ID_PERFIL 
		WHERE	ID_USUARIO = @ID_USUARIO;

	SET @RETCODE = 0
		SET @MENSAJE = 'Usuario editado correctamente'
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

