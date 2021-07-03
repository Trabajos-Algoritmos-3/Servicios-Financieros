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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fran 7/2/2021 22:33:17'!
test08ReceptiveAccountCanMakeATransactionToAnotherReceptiveAccount

	| fromAccount toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: fromAccount.
	Transfer from: fromAccount to: toAccount theAmountOf: 100 * peso.
	
	self assert: 0 equals: fromAccount balance.
	self assert: 100 * peso equals: toAccount balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'fran 7/2/2021 22:56:09'!
test09BothReceptivesAccountsKnowRegisteredTransferences

	| transfer fromAccount toAccount |
	
	fromAccount _ ReceptiveAccount new.
	toAccount _ ReceptiveAccount new.
	
	Deposit register: 100 * peso on: fromAccount.
	transfer _ Transfer from: fromAccount to: toAccount theAmountOf: 100 * peso.
	
	self assert: (fromAccount hasRegistered: transfer).
	self assert: (toAccount hasRegistered: transfer).
	
	
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
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


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'fran 7/2/2021 23:44:03'!
initializeFor: aValue
	value _ aValue.! !


!Transfer methodsFor: 'value' stamp: 'fran 7/2/2021 22:47:18'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'fran 7/2/2021 23:42:51'!
for: aValue
	^ self new initializeFor: aValue ! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'fran 7/2/2021 23:43:29'!
from: accountSender to: accountReciver theAmountOf: aValue
	
	|transfer|
	
	transfer _ self for: aValue.
	
	accountSender registerWithdraw: transfer.
	accountReciver registerDeposit: transfer.
	
	^ transfer.! !


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
