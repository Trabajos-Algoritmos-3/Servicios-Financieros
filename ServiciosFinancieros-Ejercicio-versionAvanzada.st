!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/6/2021 13:53:54'!
test08ReceptiveAccountCanMakeATransactionToAnotherReceptiveAccount

	| fromAccount toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: fromAccount.
	AccountsTransferences from: fromAccount to: toAccount for: 100 * peso.
	
	self assert: 0 equals: fromAccount balance.
	self assert: 100 * peso equals: toAccount balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ff 7/6/2021 13:55:47'!
test09BothReceptivesAccountsKnowRegisteredTransferences

	| transfer fromAccount toAccount |
	
	fromAccount _ ReceptiveAccount new.
	toAccount _ ReceptiveAccount new.
	
	Deposit register: 100 * peso on: fromAccount.
	transfer _ AccountsTransferences from: fromAccount to: toAccount for: 100 * peso.
	
	self assert: (fromAccount hasRegistered: transfer).
	self assert: (toAccount hasRegistered: transfer).
	
	
! !


!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 14:10:04'!
test01PortfolioCanBeEmpty

	|portfolio|
	portfolio _ Portfolio new.
	
	self assert: portfolio balance equals: 0 * peso.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 14:21:50'!
test02PortfolioCanCalculateBalanceOfMultipleAccounts

	|portfolio fedeAccount franAccount|
	portfolio _ Portfolio new.
	
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.	
	
	portfolio add: fedeAccount.
	portfolio add: franAccount.
	
	Deposit register: 100 * peso on: fedeAccount.
	Deposit register: 200 * peso on: franAccount.
	
	self assert: portfolio balance equals: 300 * peso.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 14:34:59'!
test03

	|portfolio fedeAccount franAccount deposit|
	portfolio _ Portfolio new.
	
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.	
	
	portfolio add: fedeAccount.
	portfolio add: franAccount.
	
	deposit _ Deposit register: 100 * peso on: fedeAccount.
	
	self assert: (portfolio hasRegistered: deposit) equals: true.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 14:48:13'!
test04

	|portfolio fedeAccount franAccount deposit100 deposit50 deposit10 fedeTransactions|
	portfolio _ Portfolio new.
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.	
	
	portfolio add: fedeAccount.
	portfolio add: franAccount.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	deposit50 _ Deposit register: 50 * peso on: fedeAccount.
	deposit10 _ Deposit register: 10 * peso on: franAccount.
	
	fedeTransactions _ portfolio transactions: fedeAccount.
	self assert: (fedeTransactions includes: deposit100) equals: true.
	self assert: (fedeTransactions includes: deposit50) equals: true.
	self assert: (fedeTransactions includes: deposit10) equals: false.
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 14:50:43'!
test05

	|portfolio1 portfolio2 fedeAccount franAccount|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.	
	
	portfolio1 add: fedeAccount.
	portfolio1 add: franAccount.
	
	Deposit register: 100 * peso on: fedeAccount.
	Deposit register: 50 * peso on: fedeAccount.
	Deposit register: 10 * peso on: franAccount.
	
	portfolio2 add: portfolio1.
	
	self assert: portfolio2 balance equals: 160 * peso.
	
	
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 14:52:26'!
test06

	|portfolio1 portfolio2 fedeAccount franAccount deposit|
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.	
	
	portfolio1 add: fedeAccount.
	portfolio1 add: franAccount.
	
	deposit _ Deposit register: 100 * peso on: fedeAccount.
	
	portfolio2 add: portfolio1.
	
	self assert: (portfolio2 hasRegistered: deposit) equals: true.
	
	
	! !

!ReceptiveAccountTest methodsFor: 'portfolioTest' stamp: 'ff 7/6/2021 15:01:00'!
test07

	|portfolio1 portfolio2 fedeAccount franAccount deposit10 deposit100 deposit50 fedeTransactions |
	
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	fedeAccount _ ReceptiveAccount new.
	franAccount _ ReceptiveAccount new.	
	
	portfolio1 add: fedeAccount.
	portfolio1 add: franAccount.
	portfolio2 add: portfolio1.
	
	deposit100 _ Deposit register: 100 * peso on: fedeAccount.
	deposit50 _ Deposit register: 50 * peso on: fedeAccount.
	deposit10 _ Deposit register: 10 * peso on: franAccount.
	
	fedeTransactions _ portfolio2 transactions: fedeAccount.
	self assert: (fedeTransactions includes: deposit100) equals: true.
	self assert: (fedeTransactions includes: deposit50) equals: true.
	self assert: (fedeTransactions includes: deposit10) equals: false.
	
	
	
	
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

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

!Deposit class methodsFor: 'instance creation' stamp: 'fran 7/2/2021 23:13:29'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account registerDeposit: transaction.
		
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

!Withdraw class methodsFor: 'instance creation' stamp: 'fran 7/2/2021 23:13:09'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account registerWithdraw: transaction.
		
	^ transaction! !


!classDefinition: #AccountsTransferences category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountsTransferences
	instanceVariableNames: 'sender receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountsTransferences methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:19:44'!
value
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountsTransferences class' category: 'ServiciosFinancieros-Ejercicio'!
AccountsTransferences class
	instanceVariableNames: ''!

!AccountsTransferences class methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:33:28'!
from: accountSender to: accountReceiver for: aValue
	|transferSender transferReceiver|
	
	transferSender _	TransferSender createWith: aValue .
	transferReceiver _ TransferReceiver createWith: aValue.
	
	transferSender xxx: transferReceiver.
	transferReceiver xxx: transferSender.
	
	accountSender registerWithdraw: transferSender.
	accountReceiver registerDeposit: transferReceiver.
	
	
	! !


!classDefinition: #TransferReceiver category: 'ServiciosFinancieros-Ejercicio'!
AccountsTransferences subclass: #TransferReceiver
	instanceVariableNames: 'value otherPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferReceiver methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 13:54:57'!
initializeFor: aValue
	value _ aValue.! !

!TransferReceiver methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:20:21'!
value
	^ value.! !

!TransferReceiver methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 13:51:32'!
xxx: otherHand
	otherPart _ otherHand .! !

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

!TransferSender methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 13:55:08'!
initializeFor: aValue
	value _ aValue.! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:20:30'!
value
	^value.! !

!TransferSender methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 13:51:49'!
xxx: otherHand
	otherPart _ otherHand .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSender class' category: 'ServiciosFinancieros-Ejercicio'!
TransferSender class
	instanceVariableNames: ''!

!TransferSender class methodsFor: 'as yet unclassified' stamp: 'fran 7/5/2021 21:34:46'!
createWith: aValue
	^ self new initializeFor: aValue.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'linkedAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 14:18:47'!
add: anAccount

	linkedAccounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 14:13:26'!
balance
	^linkedAccounts sum: [:anAccount | anAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 14:38:03'!
hasRegistered: aTransaccion
	linkedAccounts do: [:anAccount | (anAccount hasRegistered: aTransaccion) ifTrue: [ ^true ] ].
	^false.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 14:12:16'!
initialize
	linkedAccounts _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ff 7/6/2021 15:10:38'!
transactions: anAccount
	(linkedAccounts includes: anAccount) ifTrue:[ ^anAccount transactions].
	linkedAccounts do: [:i | (i isKindOf: Portfolio) ifTrue: [^ i transactions: anAccount ] ].
	
	! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'depositTransactions withdrawTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'fran 7/2/2021 23:35:55'!
initialize

	depositTransactions _ OrderedCollection new.
	withdrawTransactions _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fran 7/2/2021 23:36:49'!
balance

	|depositBalance withdrawBalance|

	depositBalance _ depositTransactions sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].
	withdrawBalance _ withdrawTransactions sum: [:aTransaction | aTransaction value] ifEmpty: [ 0 ].
	
	^ (depositBalance - withdrawBalance).! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fran 7/2/2021 23:26:03'!
hasRegistered: aTransaction

	^ (depositTransactions includes: aTransaction) or: (withdrawTransactions includes: aTransaction).
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fran 7/2/2021 23:16:54'!
registerDeposit: aTransaction

	depositTransactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fran 7/2/2021 23:17:23'!
registerWithdraw: aTransaction

	withdrawTransactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fran 7/2/2021 23:24:09'!
transactions 

	^ (depositTransactions union: withdrawTransactions) copy.! !
