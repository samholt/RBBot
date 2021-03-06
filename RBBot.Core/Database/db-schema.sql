/****** Object:  Table [dbo].[ExchangeState]    Script Date: 06/10/2017 00:10:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeState](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Code] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_ExchangeStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradePair]    Script Date: 06/10/2017 00:10:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradePair](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromCurrencyId] [int] NOT NULL,
	[ToCurrencyId] [int] NOT NULL,
	[MaxDailyVolatilityIndex] [decimal](18, 4) NOT NULL,
 CONSTRAINT [PK_TradePair] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangeTradePairState]    Script Date: 06/10/2017 00:10:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeTradePairState](
	[Id] [int] NOT NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Code] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_ExchangeTradePairStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Currency]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[Id] [int] NOT NULL,
	[Code] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsCrypto] [bit] NOT NULL,
	[AverageTransferTimeMinutes] [int] NOT NULL,
	[DailyVolatilityIndex] [decimal](18, 4) NOT NULL,
	[AverageTransferFee] [decimal](18, 8) NOT NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangeTradePair]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeTradePair](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TradePairId] [int] NOT NULL,
	[ExchangeId] [int] NOT NULL,
	[FeePercent] [decimal](19, 4) NOT NULL,
	[StateId] [int] NOT NULL,
 CONSTRAINT [PK_ExchangeTradePair] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Exchange]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exchange](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StateId] [int] NOT NULL,
 CONSTRAINT [PK_Exchange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ExchangeDetailView]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ExchangeDetailView]
AS
SELECT 
	ex.Id as ExchangeId,
	ex.Name as ExchangeName, 
	exs.Name as ExchangeStatus,
	c1.Code + ' - ' + c2.Code AS TradePair,
	extp.FeePercent,
	extps.Name as TradePairStatus,
	extp.Id AS ExchangeTradePairId,
	tp.Id as TradePaidId
FROM dbo.Exchange ex
inner join dbo.ExchangeState exs
on ex.StateId = exs.Id
inner join dbo.ExchangeTradePair extp
on extp.ExchangeId = ex.Id
inner join dbo.TradePair tp
on tp.Id = extp.TradePairId
inner join dbo.Currency C1
on tp.FromCurrencyId = c1.Id
inner join dbo.Currency C2
on tp.ToCurrencyId = c2.Id
inner join ExchangeTradePairState extps
on extps.Id = extp.StateId





GO
/****** Object:  Table [dbo].[TradeOpportunityType]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunityType](
	[Id] [int] NOT NULL,
	[Code] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_TradeOpportunityType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeOpportunityState]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunityState](
	[Id] [int] NOT NULL,
	[Code] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_TradeOpportunityState] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeOpportunityValue]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunityValue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TradeOpportunityId] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[PotentialMargin] [decimal](18, 8) NOT NULL,
 CONSTRAINT [PK_TradeOpportunityValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeOpportunity]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TradeOpportunityTypeId] [int] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[IsExecuted] [bit] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[ExecutedTime] [datetime] NULL,
	[IsSimulation] [bit] NOT NULL,
	[TradeOpportunityStateId] [int] NOT NULL,
	[Description] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_TradeOpportunity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[TradeOpportunityView]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TradeOpportunityView]
AS
	SELECT 
		op.[Id],
		opt.Code AS OppType,
		cur.Code OppCurrency,
		op.[IsExecuted],
		op.[StartTime],
		op.[EndTime],
		op.[ExecutedTime],
		op.[IsSimulation],
		ops.Code AS OppState,
		opv.PotentialMargin AS LastMargin,
		opv.Timestamp AS LastUpdate,
		op.[Description] AS OppDescription
  FROM [dbo].[TradeOpportunity] op
  INNER JOIN dbo.TradeOpportunityType opt
  on op.[TradeOpportunityTypeId] = opt.Id
  INNER JOIN dbo.Currency cur
  on cur.Id = op.CurrencyId
  INNER JOIN [dbo].[TradeOpportunityState] ops
  on ops.Id = op.[TradeOpportunityStateId]
  LEFT OUTER JOIN TradeOpportunityValue opv
  on opv.Id = (SELECT TOP 1 Id FROM TradeOpportunityValue WHERE TradeOpportunityId = op.Id ORDER BY Id DESC)




GO
/****** Object:  Table [dbo].[MarketPrice]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarketPrice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeTradePairId] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Price] [decimal](18, 8) NOT NULL,
 CONSTRAINT [PK_MarketPrice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Setting]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeId] [int] NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsEncrypted] [bit] NOT NULL,
	[ShouldBeEncrypted] [bit] NOT NULL,
 CONSTRAINT [PK_SystemSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeAccount]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeAccount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeId] [int] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[Address] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExchangeIdentifier] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Balance] [decimal](18, 8) NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_TradeAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeOpportunityRequirement]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunityRequirement](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TradeOpportunityId] [int] NOT NULL,
	[TradeOpportunityRequirementTypeId] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[RequirementMet] [bit] NOT NULL,
	[Message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemIdentifier] [varchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_TradeOpportunityRequirement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeOpportunityRequirementType]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunityRequirementType](
	[Id] [int] NOT NULL,
	[Name] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Code] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_TradeOpportunityRequirementType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TradeOpportunityTransaction]    Script Date: 06/10/2017 00:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeOpportunityTransaction](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IsReal] [bit] NOT NULL,
	[TradeOpportunityId] [int] NOT NULL,
	[FromAccountId] [int] NOT NULL,
	[ToAccountId] [int] NOT NULL,
	[FromAmount] [decimal](18, 8) NOT NULL,
	[ToAmount] [decimal](18, 8) NOT NULL,
	[FromAccountFee] [decimal](18, 8) NOT NULL,
	[ToAccountFee] [decimal](18, 8) NOT NULL,
	[FromAccountBalanceBeforeTx] [decimal](18, 8) NOT NULL,
	[ToAccountBalanceBeforeTx] [decimal](18, 8) NOT NULL,
	[ExchangeRate] [decimal](18, 0) NOT NULL,
	[EstimatedFromAccountBalanceAfterTx] [decimal](18, 8) NOT NULL,
	[EstimatedToAccountBalanceAfterTx] [decimal](18, 8) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ExternalTransactionId] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ExecuteOnExchangeId] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Index [UX_ExchangeTradePair]    Script Date: 06/10/2017 00:10:57 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_ExchangeTradePair] ON [dbo].[ExchangeTradePair]
(
	[TradePairId] ASC,
	[ExchangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MarketPrice]    Script Date: 06/10/2017 00:10:57 ******/
CREATE NONCLUSTERED INDEX [IX_MarketPrice] ON [dbo].[MarketPrice]
(
	[ExchangeTradePairId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UX_SystemSettingUnique]    Script Date: 06/10/2017 00:10:57 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_SystemSettingUnique] ON [dbo].[Setting]
(
	[ExchangeId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TradeOpportunityValue]    Script Date: 06/10/2017 00:10:57 ******/
CREATE NONCLUSTERED INDEX [IX_TradeOpportunityValue] ON [dbo].[TradeOpportunityValue]
(
	[TradeOpportunityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [DF_Currency_IsCrypto]  DEFAULT ((1)) FOR [IsCrypto]
GO
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [DF_Currency_AverageConfirmationTimeMinutes]  DEFAULT ((0)) FOR [AverageTransferTimeMinutes]
GO
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [DF_Currency_Volatility]  DEFAULT ((0)) FOR [DailyVolatilityIndex]
GO
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [DF_Currency_AverageTransferFee]  DEFAULT ((0)) FOR [AverageTransferFee]
GO
ALTER TABLE [dbo].[Setting] ADD  CONSTRAINT [DF_SystemSetting_IsEncrypted]  DEFAULT ((0)) FOR [IsEncrypted]
GO
ALTER TABLE [dbo].[Setting] ADD  CONSTRAINT [DF_Setting_ShouldBeEncrypted]  DEFAULT ((0)) FOR [ShouldBeEncrypted]
GO
ALTER TABLE [dbo].[TradeOpportunity] ADD  CONSTRAINT [DF_TradeOpportunity_IsExecuted]  DEFAULT ((0)) FOR [IsExecuted]
GO
ALTER TABLE [dbo].[TradePair] ADD  CONSTRAINT [DF_TradePair_Maximum12HourVolatilityIndex]  DEFAULT ((0)) FOR [MaxDailyVolatilityIndex]
GO
ALTER TABLE [dbo].[Exchange]  WITH CHECK ADD  CONSTRAINT [FK_Exchange_ExchangeStatus] FOREIGN KEY([StateId])
REFERENCES [dbo].[ExchangeState] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Exchange] CHECK CONSTRAINT [FK_Exchange_ExchangeStatus]
GO
ALTER TABLE [dbo].[ExchangeState]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeStatus_ExchangeStatus] FOREIGN KEY([Id])
REFERENCES [dbo].[ExchangeState] ([Id])
GO
ALTER TABLE [dbo].[ExchangeState] CHECK CONSTRAINT [FK_ExchangeStatus_ExchangeStatus]
GO
ALTER TABLE [dbo].[ExchangeTradePair]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeTradePair_Exchange] FOREIGN KEY([ExchangeId])
REFERENCES [dbo].[Exchange] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ExchangeTradePair] CHECK CONSTRAINT [FK_ExchangeTradePair_Exchange]
GO
ALTER TABLE [dbo].[ExchangeTradePair]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeTradePair_ExchangeTradePair] FOREIGN KEY([Id])
REFERENCES [dbo].[ExchangeTradePair] ([Id])
GO
ALTER TABLE [dbo].[ExchangeTradePair] CHECK CONSTRAINT [FK_ExchangeTradePair_ExchangeTradePair]
GO
ALTER TABLE [dbo].[ExchangeTradePair]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeTradePair_ExchangeTradePairStatus] FOREIGN KEY([StateId])
REFERENCES [dbo].[ExchangeTradePairState] ([Id])
GO
ALTER TABLE [dbo].[ExchangeTradePair] CHECK CONSTRAINT [FK_ExchangeTradePair_ExchangeTradePairStatus]
GO
ALTER TABLE [dbo].[ExchangeTradePair]  WITH CHECK ADD  CONSTRAINT [FK_ExchangeTradePair_TradePair] FOREIGN KEY([TradePairId])
REFERENCES [dbo].[TradePair] ([Id])
GO
ALTER TABLE [dbo].[ExchangeTradePair] CHECK CONSTRAINT [FK_ExchangeTradePair_TradePair]
GO
ALTER TABLE [dbo].[MarketPrice]  WITH CHECK ADD  CONSTRAINT [FK_MarketPrice_ExchangeTradePair] FOREIGN KEY([ExchangeTradePairId])
REFERENCES [dbo].[ExchangeTradePair] ([Id])
GO
ALTER TABLE [dbo].[MarketPrice] CHECK CONSTRAINT [FK_MarketPrice_ExchangeTradePair]
GO
ALTER TABLE [dbo].[Setting]  WITH CHECK ADD  CONSTRAINT [FK_Setting_Exchange] FOREIGN KEY([ExchangeId])
REFERENCES [dbo].[Exchange] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Setting] CHECK CONSTRAINT [FK_Setting_Exchange]
GO
ALTER TABLE [dbo].[TradeAccount]  WITH CHECK ADD  CONSTRAINT [FK_TradeAccount_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
GO
ALTER TABLE [dbo].[TradeAccount] CHECK CONSTRAINT [FK_TradeAccount_Currency]
GO
ALTER TABLE [dbo].[TradeAccount]  WITH CHECK ADD  CONSTRAINT [FK_TradeAccount_Exchange] FOREIGN KEY([ExchangeId])
REFERENCES [dbo].[Exchange] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TradeAccount] CHECK CONSTRAINT [FK_TradeAccount_Exchange]
GO
ALTER TABLE [dbo].[TradeOpportunity]  WITH CHECK ADD  CONSTRAINT [FK_TradeOpportunity_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunity] CHECK CONSTRAINT [FK_TradeOpportunity_Currency]
GO
ALTER TABLE [dbo].[TradeOpportunity]  WITH CHECK ADD  CONSTRAINT [FK_TradeOpportunity_TradeOpportunityType] FOREIGN KEY([TradeOpportunityTypeId])
REFERENCES [dbo].[TradeOpportunityType] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunity] CHECK CONSTRAINT [FK_TradeOpportunity_TradeOpportunityType]
GO
ALTER TABLE [dbo].[TradeOpportunityRequirement]  WITH CHECK ADD  CONSTRAINT [FK_TradeOpportunityRequirement_TradeOpportunityRequirement] FOREIGN KEY([Id])
REFERENCES [dbo].[TradeOpportunityRequirement] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityRequirement] CHECK CONSTRAINT [FK_TradeOpportunityRequirement_TradeOpportunityRequirement]
GO
ALTER TABLE [dbo].[TradeOpportunityRequirement]  WITH CHECK ADD  CONSTRAINT [FK_TradeOpportunityRequirement_TradeOpportunityRequirementType] FOREIGN KEY([TradeOpportunityRequirementTypeId])
REFERENCES [dbo].[TradeOpportunityRequirementType] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityRequirement] CHECK CONSTRAINT [FK_TradeOpportunityRequirement_TradeOpportunityRequirementType]
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TradeOpportunityTransaction_Exchange] FOREIGN KEY([ExecuteOnExchangeId])
REFERENCES [dbo].[Exchange] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction] CHECK CONSTRAINT [FK_TradeOpportunityTransaction_Exchange]
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TradeTransaction_TradeFromAccount] FOREIGN KEY([FromAccountId])
REFERENCES [dbo].[TradeAccount] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction] CHECK CONSTRAINT [FK_TradeTransaction_TradeFromAccount]
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TradeTransaction_TradeOpportunity] FOREIGN KEY([TradeOpportunityId])
REFERENCES [dbo].[TradeOpportunity] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction] CHECK CONSTRAINT [FK_TradeTransaction_TradeOpportunity]
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TradeTransaction_TradeToAccount] FOREIGN KEY([ToAccountId])
REFERENCES [dbo].[TradeAccount] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityTransaction] CHECK CONSTRAINT [FK_TradeTransaction_TradeToAccount]
GO
ALTER TABLE [dbo].[TradeOpportunityValue]  WITH CHECK ADD  CONSTRAINT [FK_TradeOpportunityValue_TradeOpportunity] FOREIGN KEY([TradeOpportunityId])
REFERENCES [dbo].[TradeOpportunity] ([Id])
GO
ALTER TABLE [dbo].[TradeOpportunityValue] CHECK CONSTRAINT [FK_TradeOpportunityValue_TradeOpportunity]
GO
ALTER TABLE [dbo].[TradePair]  WITH CHECK ADD  CONSTRAINT [FK_TradePair_FromCurrency] FOREIGN KEY([FromCurrencyId])
REFERENCES [dbo].[Currency] ([Id])
GO
ALTER TABLE [dbo].[TradePair] CHECK CONSTRAINT [FK_TradePair_FromCurrency]
GO
ALTER TABLE [dbo].[TradePair]  WITH CHECK ADD  CONSTRAINT [FK_TradePair_ToCurrency] FOREIGN KEY([ToCurrencyId])
REFERENCES [dbo].[Currency] ([Id])
GO
ALTER TABLE [dbo].[TradePair] CHECK CONSTRAINT [FK_TradePair_ToCurrency]
GO
/****** Object:  StoredProcedure [dbo].[AddExchangePair]    Script Date: 06/10/2017 00:10:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.AddExchangePair 
	@ExchangeName AS VARCHAR(50), 
	@FromCurrencyCode AS VARCHAR(10), 
	@ToCurrencyCode AS VARCHAR(10),
	@FeePercent AS DECIMAL(19,4),
	@StatusCode AS VARCHAR(10)
AS
BEGIN
	DECLARE @StatusId INT
	DECLARE @FromCurrencyId INT
	DECLARE @ToCurrencyId INT
	DECLARE @ExchangeId INT
	DECLARE @TradePairId INT

	SELECT @StatusId = Id FROM ExchangeTradePairStatus WHERE Code = @StatusCode
	IF @StatusId IS NULL
	BEGIN
		PRINT 'Exchange Trade-Pair Status not valid'
		RETURN -10
	END
	SELECT @ExchangeId = Id FROM Exchange WHERE Name = @ExchangeName
	IF @ExchangeId  IS NULL
	BEGIN
		PRINT 'Exchange Name not valid'
		RETURN -20
	END
	SELECT @FromCurrencyId = Id FROM Currency WHERE Code = @FromCurrencyCode
	IF @FromCurrencyId IS NULL
	BEGIN
		PRINT 'From Currency Code is not valid'
		RETURN -30
	END
	SELECT @ToCurrencyId = Id FROM Currency WHERE Code = @ToCurrencyCode
	IF @ToCurrencyId IS NULL
	BEGIN
		PRINT 'To Currency Code is not valid'
		RETURN -40
	END

	IF @FeePercent < 0 or @FeePercent > 10
	BEGIN
		PRINT 'Fee percentage is not valid'
		RETURN -50
	END

	SELECT @TradePairId = Id FROM TradePair WHERE FromCurrencyId = @FromCurrencyId AND ToCurrencyId = @ToCurrencyId

	-- If the trade pair doesn't exist, create it now.
	IF @TradePairId IS NULL 
	BEGIN
		INSERT INTO TradePair(FromCurrencyId, ToCurrencyId) VALUES(@FromCurrencyId, @ToCurrencyId)
		SET @TradePairId = @@IDENTITY
	END

	-- Now insert the exchange trade pair
	INSERT INTO ExchangeTradePair(ExchangeId,TradePairId, FeePercent, StatusId)
	VALUES (@ExchangeId, @TradePairId, @FeePercent, @StatusId)

	-- Return 1. Success
	RETURN 1
	
END

GO
