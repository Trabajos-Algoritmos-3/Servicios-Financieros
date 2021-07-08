!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'fedeAccount franAccount portfolioA portfolioB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:37'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: fedeAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:37'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: fedeAccount .
		
	self assert: 100 * peso equals: fedeAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:37'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 * peso on: fedeAccount .
	Withdraw register: 50 * peso on: fedeAccount .
		
	self assert: 50 * peso equals: fedeAccount balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:37'!
test04WithdrawValueMustBePositive 

	| withdraw50 |
	

	withdraw50 := 50 * peso.
	
	self assert: withdraw50 equals: (Withdraw register: withdraw50 on: fedeAccount ) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:37'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit100 withdraw50 |
	
	deposit100 := Deposit register: 100 * peso on: fedeAccount .
	withdraw50 := Withdraw register: 50 * peso on: fedeAccount .
		
	self assert: (fedeAccount hasRegistered: deposit100).
	self assert: (fedeAccount hasRegistered: withdraw50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:36'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit100 withdraw50 |
	
	deposit100 :=  Deposit for: 100 * peso.
	withdraw50 := Withdraw for: 50 * peso.
		
	self deny: (fedeAccount hasRegistered: deposit100).
	self deny: (fedeAccount hasRegistered: withdraw50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:37'!
test07AccountKnowsItsTransactions 

	| deposit50 |
	
	
	deposit50 := Deposit register: 50 * peso on: fedeAccount .
		
	self assert: 1 equals: fedeAccount transactions size.
	self assert: (fedeAccount transactions includes: deposit50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:45'!
test08ReceptiveAccountCanMakeATransactionToAnotherReceptiveAccount
	
	Deposit register: 100 * peso on: fedeAccount .
	AccountsTransferences from: fedeAccount to: franAccount for: 100 * peso.
	
	self assert: 0 equals: fedeAccount balance.
	self assert: 100 * peso equals: franAccount balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/8/2021 16:35:45'!
test09BothReceptivesAccountsKnowRegisteredTransferences

	| transfer100 |
	
	
	Deposit register: 100 * peso on: fedeAccount.
	transfer100 _ AccountsTransferences from: fedeAccount to: franAccount for: 100 * peso.
	
	self assert: transfer100 sender value equals: transfer100 sender counterPart value.
	self assert: transfer100 receiver value equals: transfer100 receiver counterPart value.
	! !


!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:36:41'!
test10PortfolioCanBeEmpty
	
	self assert: portfolioA balance equals: 0 * peso.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:25'!
test11PortfolioCanCalculateBalanceOfMultipleAccounts

	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	
	Deposit register: 100 * peso on: fedeAccount.
	Deposit register: 200 * peso on: franAccount.
	
	self assert: portfolioA balance equals: 300 * peso.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:25'!
test12PortfolioKnowsRegisteredTransactions

	|deposit100|
	
	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	
	self assert: (portfolioA hasRegistered: deposit100) equals: true.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:25'!
test13PortfolioKnowsTransacionsOfAReceptiveAccount

	|deposit100 deposit50 deposit10 fedeTransactions|
	
	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	deposit50 _ Deposit register: 50 * peso on: fedeAccount.
	deposit10 _ Deposit register: 10 * peso on: franAccount.
	
	fedeTransactions _ portfolioA transactions: fedeAccount.
	self assert: (fedeTransactions includes: deposit100) equals: true.
	self assert: (fedeTransactions includes: deposit50) equals: true.
	self assert: (fedeTransactions includes: deposit10) equals: false.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:25'!
test14PortfolioCanCalculateBalanceOfAPortfolio
	
	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	
	Deposit register: 100 * peso on: fedeAccount.
	Deposit register: 50 * peso on: fedeAccount.
	Deposit register: 10 * peso on: franAccount.
	
	portfolioB register: portfolioA.
	
	self assert: portfolioB balance equals: 160 * peso.
	
	
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:24'!
test15PortfolioKnowsRegisteredTransacionsOfAPortfolio

	|deposit100|
	
	
	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	
	portfolioB register: portfolioA.
	
	self assert: (portfolioB hasRegistered: deposit100) equals: true.
	
	
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:25'!
test16PortfolioKnowsTransactionsOfAReceptiveAccountInsideAnotherPortfolio

	|deposit10 deposit100 deposit50 fedeTransactions |
	
	
	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	portfolioB register: portfolioA.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	deposit50 _ Deposit register: 50 * peso on: fedeAccount.
	deposit10 _ Deposit register: 10 * peso on: franAccount.
	
	fedeTransactions _ portfolioB transactions: fedeAccount.
	self assert: (fedeTransactions includes: deposit100) equals: true.
	self assert: (fedeTransactions includes: deposit50) equals: true.
	self assert: (fedeTransactions includes: deposit10) equals: false.
	
	
	
	
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/8/2021 16:57:25'!
test17PortfolioKnowsTransacionsOfAPortfolio

	|deposit10 deposit100 deposit50 portfolio1Transactions |
	
	
	portfolioA register: fedeAccount.
	portfolioA register: franAccount.
	portfolioB register: portfolioA.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	deposit50 _ Deposit register: 50 * peso on: fedeAccount.
	deposit10 _ Deposit register: 10 * peso on: franAccount.
	
	portfolio1Transactions _ portfolioB transactions: portfolioA.
	self assert: (portfolio1Transactions includes: deposit100) equals: true.
	self assert: (portfolio1Transactions includes: deposit50) equals: true.
	self assert: (portfolio1Transactions includes: deposit10) equals: true.
	
	
	
	
	! !


!ReceptiveAccountTest methodsFor: 'setUp/tearDown' stamp: 'ff 7/8/2021 16:36:29'!
setUp
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.
	portfolioA _ Portfolio new.
	portfolioB _ Portfolio new.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ff 7/8/2021 16:50:21'!
effectOnBalance
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'fran 7/5/2021 19:20:59'!
value 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'fran 7/2/2021 23:34:47'!
register: aValue on: account

	self subclassResponsibility.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'fran 7/2/2021 22:20:49'!
initializeFor: aValue
	value _ aValue.! !


!Deposit methodsFor: 'value' stamp: 'ff 7/8/2021 16:49:45'!
effectOnBalance
	^value.! !

!Deposit methodsFor: 'value' stamp: 'fran 7/2/2021 22:23:02'!
value
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'ff 7/8/2021 16:52:12'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'fran 7/2/2021 23:37:15'!
initializeFor: aValue
	value _ aValue.! !


!Withdraw methodsFor: 'value' stamp: 'ff 7/8/2021 16:50:08'!
effectOnBalance
	^value negated.! !

!Withdraw methodsFor: 'value' stamp: 'fran 7/2/2021 22:22:51'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'ff 7/8/2021 16:52:18'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #AccountsTransferences category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountsTransferences
	instanceVariableNames: 'sender receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountsTransferences methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 16:20:48'!
initializeWithSender: transferSender andReceiver: transferReceiver

	sender _ transferSender.
	receiver _ transferReceiver.
	
	sender setCounterPart: receiver.
	receiver setCounterPart: sender.! !

!AccountsTransferences methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 16:19:11'!
receiver
	^receiver ! !

!AccountsTransferences methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 16:19:02'!
sender
	^sender ! !

!AccountsTransferences methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:19:44'!
value
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountsTransferences class' category: 'ServiciosFinancieros-Ejercicio'!
AccountsTransferences class
	instanceVariableNames: ''!

!AccountsTransferences class methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 16:53:28'!
from: accountSender to: accountReceiver for: aValue
	|transferSender transferReceiver|
	
	transferSender _	TransferSender createWith: aValue. 
	transferReceiver _ TransferReceiver createWith: aValue.
	
	accountSender register: transferSender.
	accountReceiver register: transferReceiver.
	
	^self new initializeWithSender: transferSender andReceiver: transferReceiver.
	
	
	! !


!classDefinition: #TransferReceiver category: 'ServiciosFinancieros-Ejercicio'!
AccountsTransferences subclass: #TransferReceiver
	instanceVariableNames: 'value otherPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferReceiver methodsFor: 'initialization' stamp: 'ff 7/6/2021 13:54:57'!
initializeFor: aValue
	value _ aValue.! !


!TransferReceiver methodsFor: 'private' stamp: 'ff 7/8/2021 16:20:48'!
setCounterPart: otherHand
	otherPart _ otherHand .! !


!TransferReceiver methodsFor: 'accessing' stamp: 'ff 7/8/2021 16:22:33'!
counterPart
	^otherPart .! !

!TransferReceiver methodsFor: 'accessing' stamp: 'ff 7/8/2021 16:54:26'!
effectOnBalance
	^value.! !

!TransferReceiver methodsFor: 'accessing' stamp: 'fran 7/5/2021 21:20:21'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferReceiver class' category: 'ServiciosFinancieros-Ejercicio'!
TransferReceiver class
	instanceVariableNames: ''!

!TransferReceiver class methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:34:40'!
createWith: aValue
	^ self new initializeFor: aValue.! !


!classDefinition: #TransferSender category: 'ServiciosFinancieros-Ejercicio'!
AccountsTransferences subclass: #TransferSender
	instanceVariableNames: 'value otherPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferSender methodsFor: 'initialization' stamp: 'ff 7/6/2021 13:55:08'!
initializeFor: aValue
	value _ aValue.! !


!TransferSender methodsFor: 'private' stamp: 'ff 7/8/2021 16:20:48'!
setCounterPart: otherHand
	otherPart _ otherHand .! !


!TransferSender methodsFor: 'accessing' stamp: 'ff 7/8/2021 16:22:22'!
counterPart
	^otherPart .! !

!TransferSender methodsFor: 'accessing' stamp: 'ff 7/8/2021 16:54:53'!
effectOnBalance
	^value negated.! !

!TransferSender methodsFor: 'accessing' stamp: 'fran 7/5/2021 21:20:30'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSender class' category: 'ServiciosFinancieros-Ejercicio'!
TransferSender class
	instanceVariableNames: ''!

!TransferSender class methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:34:46'!
createWith: aValue
	^ self new initializeFor: aValue.! !


!classDefinition: #BankAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!BankAccount methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 17:02:42'!
balance
	self subclassResponsibility.! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 17:03:05'!
hasRegistered: aTransaccion
	self subclassResponsibility.! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 17:03:24'!
register: anAccount
	self subclassResponsibility.! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'ff 7/8/2021 17:03:46'!
transactions: anAccount
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'linkedAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'fran 7/7/2021 22:47:20'!
initialize
	linkedAccounts _ OrderedCollection new.! !


!Portfolio methodsFor: 'private' stamp: 'fran 7/7/2021 22:49:32'!
transactions
	|allTransactions|
	allTransactions _ OrderedCollection new.
	linkedAccounts do: [:anAccount | allTransactions _ (allTransactions union: (anAccount transactions))].
	^ allTransactions.! !


!Portfolio methodsFor: 'main protocol' stamp: 'ff 7/6/2021 14:13:26'!
balance
	^linkedAccounts sum: [:anAccount | anAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'ff 7/6/2021 14:38:03'!
hasRegistered: aTransaccion
	linkedAccounts do: [:anAccount | (anAccount hasRegistered: aTransaccion) ifTrue: [ ^true ] ].
	^false.! !

!Portfolio methodsFor: 'main protocol' stamp: 'ff 7/8/2021 17:02:05'!
register: anAccount

	linkedAccounts add: anAccount.! !

!Portfolio methodsFor: 'main protocol' stamp: 'fran 7/7/2021 22:35:03'!
transactions: anAccount
	(linkedAccounts includes: anAccount) ifTrue:[ ^anAccount transactions].
	linkedAccounts do: [:i | (i isKindOf: Portfolio) ifTrue: [^ i transactions: anAccount ] ].
	! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ff 7/8/2021 16:59:25'!
initialize
	transactions _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ff 7/8/2021 16:55:43'!
balance

	|transactionsBalance |
	transactionsBalance _ transactions sum: [:aTransaction | aTransaction effectOnBalance ] ifEmpty: [ 0 ].
	^transactionsBalance.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ff 7/8/2021 16:55:32'!
hasRegistered: aTransaction

	^transactions includes: aTransaction.
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ff 7/8/2021 17:01:51'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ff 7/8/2021 16:55:25'!
transactions 

	^transactions copy.! !
