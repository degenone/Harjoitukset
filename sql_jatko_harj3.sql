USE [Projekti]
GO

/****** Object:  Trigger [dbo].[Tr_Uusiprojekti]    Script Date: 23.1.2020 13.39.29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Tr_Uusiprojekti] ON [dbo].[Projektit]
INSTEAD OF INSERT
AS
	DECLARE @Nimi varchar(100), @Aiemmat int;

	SELECT @Nimi = Nimi FROM inserted
	SELECT @Aiemmat = COUNT(Nimi) FROM Projektit WHERE Nimi LIKE CONCAT(@Nimi, '%')

	IF @Aiemmat = 0
	BEGIN
		INSERT Projektit (Nimi) VALUES (@Nimi)
		PRINT 'Projekti lisätty'
	END
	IF @Aiemmat > 0
	BEGIN
		INSERT Projektit (Nimi) VALUES (CONCAT(@Nimi, @Aiemmat + 1))
		PRINT 'Projekti lisätty liitteellä'
	END
GO

ALTER TABLE [dbo].[Projektit] ENABLE TRIGGER [Tr_Uusiprojekti]
GO


