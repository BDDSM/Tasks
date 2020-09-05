﻿
&НаКлиенте
Процедура КомандаНастройки(Команда)
	ОткрытьФорму("Обработка.узТекущиеДела.Форма.ФормаНастройки",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура КомандаОбновить(Команда)
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьТекущиеДелаНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.ОбновитьНаСервере();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");	
КонецПроцедуры 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Объект.НаДату = ТекущаяДатаСеанса();
	Объект.НаДатуКонецДня = КонецДня(Объект.НаДату);
	Объект.ПоказыватьСегодня = Истина;
	Объект.ПоказыватьНаНеделе = Истина;
	Объект.ПоказыватьПозже = Истина;
	
	узИспользоватьУчетВремени = Константы.узИспользоватьУчетВремени.Получить();
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	ОтключитьВозможностьСозданиеРегламентныхТекущихДел = Справочники.узКонстанты.ПолучитьЗначениеКонстанты(
		"ОтключитьВозможностьСозданиеРегламентныхТекущихДел",Тип("Булево"),Отказ,Истина,Истина);
	
	ЗаполнитьТекущиеДелаНаСервере();
	УстановитьВидимостьДоступность();
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность(ДопПараметры = Неопределено)
	Элементы.ГруппаДопСведения.Видимость = Ложь;
	//Элементы.ТЧТекущиеДелаГруппаЗадачаНомерЗадачи.Видимость = Ложь;
	//Элементы.ТЧТекущиеДелаВопрос.Видимость = Ложь;
	Элементы.ТЧТекущиеДелаВыполнено.Видимость = Ложь;
	Элементы.ТЧТекущиеДелаДатаВыполнения.Видимость = Ложь;
	Элементы.ГруппаНастройкаРегламента.Видимость = Ложь;
	Элементы.КомандаСохранитьРегламентноеТекущееДело.Видимость = Ложь;
	Элементы.ПоказыватьРегламентные.Видимость = Ложь;
	
	Если ПоказыватьДопСведения Тогда
		Элементы.ГруппаДопСведения.Видимость = Истина;
	Иначе
		//Элементы.ТЧТекущиеДелаГруппаЗадачаНомерЗадачи.Видимость = Истина;
		//Элементы.ТЧТекущиеДелаВопрос.Видимость = Истина;
	КонецЕсли;
	
	ГруппаТекДел_Регламентное = ПредопределенноеЗначение("Справочник.узГруппыТекущихДел.Регламентное");
	пГруппаТекущегоДела = Неопределено;
	СтрокаТЧТекущиеДела = Неопределено;
	
	Если ДопПараметры <> Неопределено Тогда
		СтрокаТЧТекущиеДела = ДопПараметры.СтрокаТЧТекущиеДела;	
	Конецесли;
	Если СтрокаТЧТекущиеДела = Неопределено тогда
		Элементы.ТЧТекущиеДелаВыполнено.Видимость = Истина;
		Элементы.ТЧТекущиеДелаДатаВыполнения.Видимость = Истина;
	Иначе
		пГруппаТекущегоДела = СтрокаТЧТекущиеДела.ГруппаТекущегоДела;
	Конецесли;	
	
	Если пГруппаТекущегоДела = ГруппаТекДел_Регламентное Тогда 
		Элементы.ГруппаНастройкаРегламента.Видимость = Истина;
		Если МодифицированностьТекущегоДела Тогда
			Элементы.КомандаСохранитьРегламентноеТекущееДело.Видимость = Истина
		Конецесли;
	Иначе
		Элементы.ТЧТекущиеДелаВыполнено.Видимость = Истина;
		Элементы.ТЧТекущиеДелаДатаВыполнения.Видимость = Истина;
	Конецесли;
	
	Если НЕ ОтключитьВозможностьСозданиеРегламентныхТекущихДел Тогда
		Элементы.ПоказыватьРегламентные.Видимость = Истина;
	Конецесли;
КонецПроцедуры 

&НаСервере
Процедура ЗаполнитьТекущиеДелаНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.ЗаполнитьТекущиеДела();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаСервере
Процедура СохранитьТекущиеДелаНаСервере()
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.СохранитьТекущиеДела();
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры 

&НаКлиенте
Процедура ПриЗакрытии()
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	Конецесли;
	
	ПриЗакрытииНаСервере();
	
	Если Объект.АвтоматическиСохранятьТекущиеДела Тогда
		ОтключитьОбработчикОжидания("СохранитьТекущиеДелаНаКлиенте");
	Конецесли;
КонецПроцедуры


&НаСервере
Процедура ПриЗакрытииНаСервере()
	СохранитьТекущиеДелаНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ТЧТекущиеДелаПриИзменении(Элемент)
	СтрокаТЧТекущиеДела = Элемент.ТекущиеДанные;
	Если СтрокаТЧТекущиеДела <> Неопределено Тогда
		СтрокаТЧТекущиеДела.Порядок = СтрокаТЧТекущиеДела.НомерСтроки;
	Конецесли;
КонецПроцедуры


&НаКлиенте
Процедура НаДатуПриИзменении(Элемент)
	ЗаполнитьТекущиеДелаНаСервере();
КонецПроцедуры


&НаСервере
Процедура ТЧТекущиеДелаПередУдалениемНаСервере(МассивТекущихДел)
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	пОбъект.УбратьТекущееДело(МассивТекущихДел);
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
КонецПроцедуры


&НаКлиенте
Процедура ТЧТекущиеДелаПередУдалением(Элемент, Отказ)
	Отказ = Истина;

	МассивВыделенныхСтрок = Элемент.ВыделенныеСтроки;	
	Если МассивВыделенныхСтрок.Количество() = 0 Тогда
		Возврат;
	Конецесли;
	
	МассивТекущихДел = ПолучитьМассивТекущихДелПоВыделеннымСтрокам(МассивВыделенныхСтрок);
	ТекстВопроса = "ВНИМАНИЕ! Вы точно хотите удалить текущие дела: " + Символы.ПС;
	
	Для каждого пТекущееДело из МассивТекущихДел цикл
		ТекстВопроса = ТекстВопроса + Символы.ПС
			+ "* "+пТекущееДело;
	Конеццикла;
	ТекстВопроса = ТекстВопроса + Символы.ПС
		+ "Продолжить?";
	
	
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("МассивТекущихДел",МассивТекущихДел);
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПослеЗакрытияВопросаТЧТекущиеДелаПередУдалением", ЭтаФорма, ДопПараметры);
	
	ПоказатьВопрос(ОповещениеОЗакрытии,ТекстВопроса,РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопросаТЧТекущиеДелаПередУдалением(Результат, ДопПараметры) Экспорт
    Если Результат = КодВозвратаДиалога.Нет Тогда
        Возврат;
	КонецЕсли;
		
	МассивТекущихДел = ДопПараметры.МассивТекущихДел;
	ТЧТекущиеДелаПередУдалениемНаСервере(МассивТекущихДел);
	
КонецПроцедуры 



&НаКлиенте
Функция ПолучитьМассивТекущихДелПоВыделеннымСтрокам(МассивВыделенныхСтрок)
	МассивТекущихДел = Новый Массив();
	Для каждого ЭлМассиваВыделенныхСтрок из МассивВыделенныхСтрок цикл
		ИдентификаторСтроки = ЭлМассиваВыделенныхСтрок;
		
		СтрокаТЧТекущиеДела = Объект.ТЧТекущиеДела.НайтиПоИдентификатору(ИдентификаторСтроки);
		пТекущееДело = СтрокаТЧТекущиеДела.ТекущееДело;
		МассивТекущихДел.Добавить(пТекущееДело);
	Конеццикла;	
	Возврат МассивТекущихДел;
КонецФункции


&НаКлиенте
Процедура КомандаВыполнил(Команда)
	МассивВыделенныхСтрок = Элементы.ТЧТекущиеДела.ВыделенныеСтроки;
	Для каждого ЭлМассиваВыделенныхСтрок из МассивВыделенныхСтрок цикл
	    ИдентификаторСтроки = ЭлМассиваВыделенныхСтрок;
		
		СтрокаТЧТекущиеДела = Объект.ТЧТекущиеДела.НайтиПоИдентификатору(ИдентификаторСтроки);			
		Если СтрокаТЧТекущиеДела.Выполнено Тогда
			Продолжить;
		Конецесли;
		СтрокаТЧТекущиеДела.ДатаВыполнения = ТекущаяДатаНаСервере();
		СтрокаТЧТекущиеДела.Выполнено = Истина;
	Конеццикла;	
	
	ОбновитьТекущиеДелаНаСервере();
	//
	//Для каждого СтрокаТЧТекущиеДела из Объект.ТЧТекущиеДела цикл
	//	пПорядокДоп = ПолучитьПорядоДопНаКлиенте(СтрокаТЧТекущиеДела.Выполнено,СтрокаТЧТекущиеДела.ДатаВыполнения,Объект.НаДату);	
	//	СтрокаТЧТекущиеДела.ПорядокДоп = пПорядокДоп;	
	//Конеццикла;
	//
	//Объект.ТЧТекущиеДела.Сортировать("ПорядокДоп,Порядок");
КонецПроцедуры

&НаКлиенте
Функция ПолучитьПорядоДопНаКлиенте(пВыполнено,пДатаВыполнения,пНаДату) 
	Возврат ПолучитьПорядоДопНаСервере(пВыполнено,пДатаВыполнения,пНаДату);
	////Такая же функция есть в модуле обработки
	//пПорядокДоп = 10;
	//Если НЕ пВыполнено Тогда
	//	пПорядокДоп = 0;
	//Иначе
	//	Если НачалоДня(пДатаВыполнения) <> пНаДату Тогда
	//		пПорядокДоп = 1;
	//	Иначе
	//		пПорядокДоп = 2;
	//	Конецесли;
	//Конецесли;
	//Возврат пПорядокДоп;
КонецФункции 

&НаСервереБезКонтекста
Функция ПолучитьПорядоДопНаСервере(пВыполнено,пДатаВыполнения,пНаДату)
	Возврат Справочники.узТекущиеДела.ПолучитьПорядоДоп(пВыполнено,пДатаВыполнения,пНаДату);	
КонецФункции 

&НаКлиенте
Процедура КомандаПоказатьДопСведения(Команда)
	ПоказыватьДопСведения = НЕ ПоказыватьДопСведения;
	Элементы.ТЧТекущиеДелаКомандаПоказатьДопСведения.Пометка = ПоказыватьДопСведения;
	
	УстановитьВидимостьДоступностьНаКлиенте();
	
	////УстановитьВидимостьДоступность();
	//СтрокаТЧТекущиеДела = Элементы.ТЧТекущиеДела.ТекущиеДанные;
	//
	//СтруктураСтрокаТЧТекущиеДела = Новый Структура();
	//СтруктураСтрокаТЧТекущиеДела.Вставить("ГруппаТекущегоДела",СтрокаТЧТекущиеДела.ГруппаТекущегоДела);
	//
	//ВТДопПараметры = Новый Структура();
	//ВТДопПараметры.Вставить("СтрокаТЧТекущиеДела",СтруктураСтрокаТЧТекущиеДела);
	//
	//УстановитьВидимостьДоступность(ВТДопПараметры);
КонецПроцедуры


&НаКлиенте
Процедура ТЧТекущиеДелаТекстСодержанияПриИзменении(Элемент)
		
КонецПроцедуры

&НаКлиенте
Процедура КомандаПредыдущийПериод(Команда)
	НаДатуНовая = ПолучитьНаДатуНовая(-1);
	ИзменитьНаДату(НаДатуНовая);
КонецПроцедуры

&НаКлиенте
Процедура КомандаНаДату(Команда)
	НаДатуНовая = НачалоДня(ТекущаяДатаНаСервере());
	ИзменитьНаДату(НаДатуНовая);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗаголовокКомандаНаДату()
	пЗаголовок = "";
	Если НачалоДня(Объект.НаДату) = НачалоДня(ТекущаяДатаНаСервере()) Тогда
		пЗаголовок = "Сегодня";
	Иначе
		пЗаголовок = Формат(Объект.НаДату,"ДФ='dd.MM ддд'");
	Конецесли;
	Элементы.ТЧТекущиеДелаКомандаНаДату.Заголовок = пЗаголовок;
КонецПроцедуры 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьЗаголовокКомандаНаДату();
	
	Если Объект.АвтоматическиСохранятьТекущиеДела Тогда
		ПодключитьОбработчикОжидания("СохранитьТекущиеДелаНаКлиенте", 600);
	Конецесли;
	
	ОбновитьНадписьЧасовЗаДень();
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьНаДату(НаДатуНовая)
	Объект.НаДату = НаДатуНовая;
	Объект.НаДатуКонецДня = КонецДня(Объект.НаДату);
	ОбновитьТекущиеДелаНаСервере();
	ОбновитьЗаголовокКомандаНаДату();
	ОбновитьНадписьЧасовЗаДень();
КонецПроцедуры 

&НаКлиенте
Функция ПолучитьНаДатуНовая(Сдвиг) 
	Если Сдвиг =  1 Тогда
		НаДатуНовая = НачалоДня(КонецДня(Объект.НаДату) + 1);
	Иначе
		НаДатуНовая = НачалоДня(Объект.НаДату - 1);
	Конецесли;
	//Если НаДатуНовая > ТекущаяДата() Тогда
	//	НаДатуНовая = Объект.НаДату;	
	//Конецесли;
	
	Возврат НаДатуНовая;
КонецФункции 

&НаКлиенте
Процедура КомандаСледующийПериод(Команда)
	НаДатуНовая = ПолучитьНаДатуНовая(1);
	ИзменитьНаДату(НаДатуНовая);
КонецПроцедуры

&НаКлиенте
Процедура ТЧТекущиеДелаПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда
		СтрокаТЧТекущиеДела = Элемент.ТекущиеДанные;
		СтрокаТЧТекущиеДела.ДатаСоздания = ТекущаяДатаНаСервере();
		СтрокаТЧТекущиеДела.ДатаТекущегоДела = СтрокаТЧТекущиеДела.ДатаСоздания;
		СтрокаТЧТекущиеДела.Порядок = СтрокаТЧТекущиеДела.НомерСтроки;
		СтрокаТЧТекущиеДела.ГруппаТекущегоДела = ПредопределенноеЗначение("Справочник.узГруппыТекущихДел.Сегодня");
	Конецесли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "КомандаДобавитьВТекущиеДела" Тогда
		ОбновитьТекущиеДелаНаСервере();
	ИначеЕсли ИмяСобытия = "узВводФактаПоЗадачеЗаписан" Тогда
		ОбновитьНадписьЧасовЗаДень();
	Конецесли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСохранить(Команда)
	//СохранитьТекущиеДелаНаКлиенте();	
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьЧасыФактЗаДеньНаСервере(НаДату,Исполнитель)
	Возврат РегистрыНакопления.узФактПоЗадачам.ПолучитьЧасыФактЗаДень(НаДату,Исполнитель);
КонецФункции 

&НаКлиенте
Процедура СохранитьТекущиеДелаНаКлиенте()
	СохранитьТекущиеДелаНаСервере();	
КонецПроцедуры 

&НаКлиенте
Процедура ПоказыватьСегодняПриИзменении(Элемент)
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьНаНеделеПриИзменении(Элемент)
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьПозжеПриИзменении(Элемент)
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура АвтоматическиСохранятьТекущиеДелаПриИзменении(Элемент)
	ПрименитьНастройкиНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ПрименитьНастройкиНаКлиенте() Экспорт
	Если Объект.АвтоматическиСохранятьТекущиеДела Тогда
		ПодключитьОбработчикОжидания("СохранитьТекущиеДелаНаКлиенте", 600);
	Иначе
		ОтключитьОбработчикОжидания("СохранитьТекущиеДелаНаКлиенте");		
	Конецесли;	
КонецПроцедуры 

&НаКлиенте
Процедура ТЧТекущиеДелаПриАктивизацииСтроки(Элемент)
	
	УстановитьВидимостьДоступностьДляТекущегоДелаНаКлиенте(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРасписаниеРегламентногоЗадания()
	
	СтрокаТЧТекущиеДела = Элементы.ТЧТекущиеДела.ТекущиеДанные;	
	Если СтрокаТЧТекущиеДела = Неопределено тогда
		Возврат;	
	Конецесли;
	
	Если НЕ ПоказыватьДопСведения Тогда
		Возврат;
	Конецесли;
	
	Если РасписаниеРегламентногоЗадания <> Неопределено Тогда
		Возврат;
	Конецесли;
	
	пГруппаТекущегоДела = СтрокаТЧТекущиеДела.ГруппаТекущегоДела;	
	ГруппаТекДел_Регламентное = ПредопределенноеЗначение("Справочник.узГруппыТекущихДел.Регламентное");	
	
	Если пГруппаТекущегоДела <> ГруппаТекДел_Регламентное Тогда
		Возврат;
	Конецесли;
	
	пТекущееДело = СтрокаТЧТекущиеДела.ТекущееДело;
		
	СтрокаТЧТекущиеДелаТекущееДело = пТекущееДело;
	
	ВТДопПараметры = Новый Структура();
	ВТДопПараметры.Вставить("ИдентификаторРасписаниеРегламента",СтрокаТЧТекущиеДела.ИдентификаторРасписаниеРегламента);
	
	РезультатФункции = ПолучитьРасписаниеРегламентногоЗаданияНаСервере(ВТДопПараметры);
	
	РасписаниеРегламентногоЗадания = РезультатФункции.РасписаниеРегламентногоЗадания;
	
КонецПроцедуры 

&НаКлиенте
Процедура УстановитьВидимостьДоступностьДляТекущегоДелаНаКлиенте(ЭтоАктивизацияСтроки = Ложь)
	
	СтрокаТЧТекущиеДела = Элементы.ТЧТекущиеДела.ТекущиеДанные;	
	Если СтрокаТЧТекущиеДела = Неопределено тогда
		Возврат;	
	Конецесли;
	
	Если НЕ ПоказыватьДопСведения Тогда
		Возврат;
	Конецесли;
	
	пТекущееДело = СтрокаТЧТекущиеДела.ТекущееДело;
	
	Если ЭтоАктивизацияСтроки Тогда
		
		Если СтрокаТЧТекущиеДелаТекущееДело = пТекущееДело Тогда
			Возврат;
		Конецесли;
		
		//Элементы.КомандаНастроитьРасписание.Заголовок = "<Расписание не задано>";
		МодифицированностьТекущегоДела = Ложь;
	Конецесли;
	
	Элементы.КомандаНастроитьРасписание.Заголовок = "" + СтрокаТЧТекущиеДела.РасписаниеРегламентногоЗаданияПредставление;
	
	//ЗаполнитьДанныеПоРегламентномуЗаданию(Истина);
	
	СтрокаТЧТекущиеДелаТекущееДело = пТекущееДело;
	
	//СтруктураСтрокаТЧТекущиеДела = Новый Структура();
	//СтруктураСтрокаТЧТекущиеДела.Вставить("ГруппаТекущегоДела",СтрокаТЧТекущиеДела.ГруппаТекущегоДела);
	//
	//ВТДопПараметры = Новый Структура();
	//ВТДопПараметры.Вставить("СтрокаТЧТекущиеДела",СтруктураСтрокаТЧТекущиеДела);
	//
	//УстановитьВидимостьДоступность(ВТДопПараметры);
	
	УстановитьВидимостьДоступностьНаКлиенте();
	
КонецПроцедуры 


&НаКлиенте
Процедура ТЧТекущиеДелаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ТЧТекущиеДелаВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьРегламентныеПриИзменении(Элемент)
	ОбновитьТекущиеДелаНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеРасписанияРегламентногоЗаданияНажатие(Элемент, СтандартнаяОбработка)
	
	
КонецПроцедуры


&НаСервереБезКонтекста
Функция ПолучитьРасписаниеРегламентногоЗаданияНаСервере(ДопПараметры) 
	
	Возврат Справочники.узТекущиеДела.ПолучитьРасписаниеРегламентногоЗадания(ДопПараметры);
	
КонецФункции 

&НаКлиенте
Процедура ТЧТекущиеДелаВключеноРегламентноеТекущееДелоПриИзменении(Элемент)
	
	МодифицированностьТекущегоДела = Истина;
	
	УстановитьВидимостьДоступностьДляТекущегоДелаНаКлиенте(Ложь);
	
КонецПроцедуры

&НаСервере
Функция Удалить_ПолучитьИдентификаторРасписаниеРегламента(ДопПараметры)
	
	ИдентификаторРасписаниеРегламента = ДопПараметры.ИдентификаторРасписаниеРегламента;	
	
	Если НЕ ЗначениеЗаполнено(ИдентификаторРасписаниеРегламента) Тогда
		ИдентификаторРасписаниеРегламента = Новый УникальныйИдентификатор;	
	Конецесли;
	
	Возврат ИдентификаторРасписаниеРегламента; 
КонецФункции 

&НаСервере
Функция СоздатьОбновитьРегламентноеЗаданиеНаСервере(ДопПараметры) 
	
	пОбъект = РеквизитФормыВЗначение("Объект"); 
	РезультатФункции = пОбъект.СоздатьОбновитьРегламентноеЗадание(ДопПараметры);
	ЗначениеВРеквизитФормы(пОбъект,"Объект");
	
	МодифицированностьТекущегоДела = Ложь;
	УстановитьВидимостьДоступность();
	
	Возврат РезультатФункции;
КонецФункции 

&НаКлиенте
Процедура ПредставлениеРасписанияРегламентногоЗаданияПриИзменении(Элемент)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура КомандаНастроитьРасписание(Команда)
	СтрокаТЧТекущиеДела = Элементы.ТЧТекущиеДела.ТекущиеДанные;	
	
	Если СтрокаТЧТекущиеДела = Неопределено тогда
		Возврат;	
	Конецесли;	
	
	ВТДопПараметры = Новый Структура();
	ВТДопПараметры.Вставить("ИдентификаторРасписаниеРегламента",СтрокаТЧТекущиеДела.ИдентификаторРасписаниеРегламента);
		
	РезультатФункции = ПолучитьРасписаниеРегламентногоЗаданияНаСервере(ВТДопПараметры);
	
	//СтрокаТЧТекущиеДела.ИдентификаторРасписаниеРегламента = РезультатФункции.ИдентификаторРасписаниеРегламента;
	
	РасписаниеРегламентногоЗадания = РезультатФункции.РасписаниеРегламентногоЗадания;
	Если РасписаниеРегламентногоЗадания = Неопределено Тогда
		РасписаниеРегламентногоЗадания = Новый РасписаниеРегламентногоЗадания;
	Конецесли;
	
	ДиалогРасписания = Новый ДиалогРасписанияРегламентногоЗадания(РасписаниеРегламентногоЗадания);
	
	ВТДопПараметрыЗакрытия = Новый Структура();
	ВТДопПараметрыЗакрытия.Вставить("СтрокаТЧТекущиеДела",СтрокаТЧТекущиеДела);

	//ДопПараметры.Вставить("",);
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ОбработатьДиалогРасписанияПриВыборе", ЭтаФорма, ВТДопПараметрыЗакрытия);
	
	ДиалогРасписания.Показать(ОповещениеОЗакрытии);
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьДиалогРасписанияПриВыборе(РезультатЗакрытия, ДопПараметры) Экспорт
	Если РезультатЗакрытия = Неопределено Тогда
		Возврат;
	Конецесли;
	
	СтрокаТЧТекущиеДела = ДопПараметры.СтрокаТЧТекущиеДела;
	МодифицированностьТекущегоДела = Истина;
	
	РасписаниеРегламентногоЗадания = РезультатЗакрытия;
	
	пРасписаниеРегламентногоЗаданияПредставление = "" + РасписаниеРегламентногоЗадания;
	
	Элементы.КомандаНастроитьРасписание.Заголовок = пРасписаниеРегламентногоЗаданияПредставление;
	
	СтрокаТЧТекущиеДела.РасписаниеРегламентногоЗаданияПредставление = пРасписаниеРегламентногоЗаданияПредставление; 
	
	УстановитьВидимостьДоступностьДляТекущегоДелаНаКлиенте(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьТекущееДелоРегламентноеНаКлиенте()
	СтрокаТЧТекущиеДела = Элементы.ТЧТекущиеДела.ТекущиеДанные;	
	Если СтрокаТЧТекущиеДела = Неопределено тогда
		Возврат;	
	Конецесли;
		
	пТекущееДело = СтрокаТЧТекущиеДела.ТекущееДело;
	Если НЕ ЗначениеЗаполнено(пТекущееДело) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Сохраните текущие дела прежде чем настраивать регламентое текущее дело";
		Сообщение.Сообщить();
		
		СтрокаТЧТекущиеДела.ВключеноРегламентноеТекущееДело = Ложь;
		Возврат;
	Конецесли;
	
	ЗаполнитьРасписаниеРегламентногоЗадания();
	
	Если НЕ УказаноРасписаниеРегламентногоЗадания() Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Укажите расписание текущего дела, перед тем как его включать";
		Сообщение.Сообщить();
		
		СтрокаТЧТекущиеДела.ВключеноРегламентноеТекущееДело = Ложь;
		
		Возврат;
	Конецесли;
	
	СтрокаТЧТекущиеДелаТекущееДело = Неопределено;	
	
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("ИдентификаторРасписаниеРегламента",СтрокаТЧТекущиеДела.ИдентификаторРасписаниеРегламента);
	ДопПараметры.Вставить("ВключеноРегламентноеТекущееДело",СтрокаТЧТекущиеДела.ВключеноРегламентноеТекущееДело);
	ДопПараметры.Вставить("ТекущееДело",пТекущееДело);
	ДопПараметры.Вставить("РасписаниеРегламентногоЗадания",РасписаниеРегламентногоЗадания);
	
	РезультатФункции = СоздатьОбновитьРегламентноеЗаданиеНаСервере(ДопПараметры);
	
	СтрокаТЧТекущиеДела.ИдентификаторРасписаниеРегламента = РезультатФункции.ИдентификаторРасписаниеРегламента;
	СтрокаТЧТекущиеДела.РасписаниеРегламентногоЗаданияПредставление = РезультатФункции.РасписаниеРегламентногоЗаданияПредставление;
	
	
	СохранитьТекущиеДелаНаКлиенте();
КонецПроцедуры 

&НаКлиенте
Функция УказаноРасписаниеРегламентногоЗадания()
	пУказаноРасписаниеРегламентногоЗадания = Ложь;
	
	МассивСвойств = Новый Массив();
	МассивСвойств.Добавить("ВремяЗавершения");
	МассивСвойств.Добавить("ВремяКонца");
	МассивСвойств.Добавить("ВремяНачала");
	МассивСвойств.Добавить("ДатаКонца");
	МассивСвойств.Добавить("ДатаНачала");
	МассивСвойств.Добавить("ДеньВМесяце");
	МассивСвойств.Добавить("ДеньНеделиВМесяце");
	МассивСвойств.Добавить("ИнтервалЗавершения");
	МассивСвойств.Добавить("ПаузаПовтора");
	МассивСвойств.Добавить("ПериодНедель");
	МассивСвойств.Добавить("ПериодПовтораВТечениеДня");
	МассивСвойств.Добавить("ПериодПовтораДней");
	
	МассивСвойствСПроверкойКоличества = Новый Массив();
	МассивСвойствСПроверкойКоличества.Добавить("ДетальныеРасписанияДня");
	МассивСвойствСПроверкойКоличества.Добавить("ДниНедели");
	МассивСвойствСПроверкойКоличества.Добавить("Месяцы");

	Для каждого ИмяСвойства из МассивСвойств Цикл
		ЗначениеСвойства = РасписаниеРегламентногоЗадания[ИмяСвойства];
		Если ЗначениеЗаполнено(ЗначениеСвойства) Тогда
			пУказаноРасписаниеРегламентногоЗадания = Истина;
			Возврат пУказаноРасписаниеРегламентногоЗадания;
		Конецесли;
	КонецЦикла;
	
	Для каждого ИмяСвойстваСПроверкойКоличества из МассивСвойствСПроверкойКоличества Цикл
		МассивЗначенияСвойства = РасписаниеРегламентногоЗадания[ИмяСвойстваСПроверкойКоличества];
		Если МассивЗначенияСвойства.Количество() > 0  Тогда
			пУказаноРасписаниеРегламентногоЗадания = Истина;
			Возврат пУказаноРасписаниеРегламентногоЗадания;
		Конецесли;
	КонецЦикла;	
	
	Возврат пУказаноРасписаниеРегламентногоЗадания;
КонецФункции 

&НаКлиенте
Процедура КомандаСохранитьРегламентноеТекущееДело(Команда)
	СохранитьТекущееДелоРегламентноеНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ТЧТекущиеДелаГруппаТекущегоДела1ПриИзменении(Элемент)
		
	УстановитьВидимостьДоступностьНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьДоступностьНаКлиенте()
	
	СтрокаТЧТекущиеДела = Элементы.ТЧТекущиеДела.ТекущиеДанные;
	
	Если СтрокаТЧТекущиеДела = Неопределено Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Для открытия дополнительных свойств необходимо указать текущее дело";
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	СтруктураСтрокаТЧТекущиеДела = Новый Структура();
	СтруктураСтрокаТЧТекущиеДела.Вставить("ГруппаТекущегоДела",СтрокаТЧТекущиеДела.ГруппаТекущегоДела);
	
	ВТДопПараметры = Новый Структура();
	ВТДопПараметры.Вставить("СтрокаТЧТекущиеДела",СтруктураСтрокаТЧТекущиеДела);
	
	УстановитьВидимостьДоступность(ВТДопПараметры);
	
КонецПроцедуры 

&НаКлиенте
Процедура ТЧТекущиеДелаПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
КонецПроцедуры

&НаКлиенте
Процедура ТЧТекущиеДелаГруппаТекущегоДелаПриИзменении(Элемент)
	УстановитьВидимостьДоступностьНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура КомандаДобавитьФактРабот(Команда)
	
	#Если ВебКлиент Тогда
		ОкноОтображения = Неопределено;
	#Иначе
		ОкноОтображения = ВариантОткрытияОкна.ОтдельноеОкно;
	#КонецЕсли
	
	МассивВыделенныхСтрок = Элементы.ТЧТекущиеДела.ВыделенныеСтроки;
	МассивЗадач = Новый Массив();
	пПримечание = "";
	пЗадачаДляФактаЗадач = Неопределено;
	Для каждого ЭлМассиваВыделенныхСтрок из МассивВыделенныхСтрок цикл
	    ИдентификаторСтроки = ЭлМассиваВыделенныхСтрок;
		
		СтрокаТЧТекущиеДела = Объект.ТЧТекущиеДела.НайтиПоИдентификатору(ИдентификаторСтроки);	
		пПримечание = пПримечание + СтрокаТЧТекущиеДела.ТекстСодержания + Символы.ПС;
		пЗадача = СтрокаТЧТекущиеДела.Задача;
		
		Если ЗначениеЗаполнено(пЗадача) 
			И МассивЗадач.Найти(пЗадача) = Неопределено Тогда
			МассивЗадач.Добавить(пЗадача);
		Конецесли;
	Конеццикла;
	
	Если МассивЗадач.Количество() = 1 Тогда
		пЗадачаДляФактаЗадач = МассивЗадач[0];
	Конецесли;
	
	пПримечание = Лев(пПримечание,СтрДлина(пПримечание)-1);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Задача", пЗадачаДляФактаЗадач);
	ПараметрыФормы.Вставить("Примечание", пПримечание);
	ПараметрыФормы.Вставить("Исполнитель", ТекущийПользователь);
	
	ОткрытьФорму("Документ.узВводФактаПоЗадаче.Форма.ФормаДокументаВводСЗадачи", 
		ПараметрыФормы,,,ОкноОтображения,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьНадписьЧасовЗаДень()
	
	Если НЕ узИспользоватьУчетВремени Тогда
		Возврат;
	Конецесли;
	
	Объект.ЧасыФактЗаДень = ПолучитьЧасыФактЗаДеньНаСервере(Объект.НаДату,ТекущийПользователь);
	Элементы.ТЧТекущиеДелаКомандаЧасовЗаДень.Заголовок = "" + Формат(Объект.ЧасыФактЗаДень,"ЧДЦ=1; ЧН=0") + " ч.";
КонецПроцедуры 


&НаКлиенте
Процедура КомандаЧасовЗаДень(Команда)
	
	
	ТабДокумент = ПолучитьТабДокументЧасыЗаДеньНаСервере(Объект.НаДату,ТекущийПользователь);
	ТабДокумент.Показать("Часы за день " + Формат(Объект.НаДату,"ДФ='dddd dd.MM.yyyy'"));
	
	//ОбъектыПечати = Новый СписокЗначений();
	//УправлениеПечатьюКлиент.НоваяКоллекцияПечатныхФорм(Идентификаторы);
	//УправлениеПечатьюКлиент.ПечатьДокументов(КоллекцияПечатныхФорм,
	//
	//ПараметрыОткрытия = Новый Структура("ИмяМенеджераПечати,ИменаМакетов,ПараметрКоманды,ПараметрыПечати");
	//ПараметрыОткрытия.ПараметрКоманды = Новый Массив;
	//ПараметрыОткрытия.ПараметрыПечати = Новый Структура;
	//ПараметрыОткрытия.Вставить("КоллекцияПечатныхФорм", КоллекцияПечатныхФорм);
	//ПараметрыОткрытия.Вставить("ОбъектыПечати", ОбъектыПечати);
	//
	//ОткрытьФорму("ОбщаяФорма.ПечатьДокументов", ПараметрыОткрытия, ВладелецФормы, КлючУникальности);
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьТабДокументЧасыЗаДеньНаСервере(НаДату,Исполнитель)
	ТабДокумент = РегистрыНакопления.узФактПоЗадачам.ПолучитьТабДокументЧасыЗаДень(НаДату, Исполнитель);
				
	Возврат ТабДокумент;
КонецФункции 

&НаСервереБезКонтекста
Функция ТекущаяДатаНаСервере() 
	Возврат ТекущаяДатаСеанса();
КонецФункции


