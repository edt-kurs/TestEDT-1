﻿
&НаСервереБезКонтекста
Процедура ЗаполнитьНаСервере()
	// Вставить содержимое обработчика.
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |	ХозрасчетныйДвиженияССубконто.Период КАК Период,
	               |	ВЫРАЗИТЬ(ХозрасчетныйДвиженияССубконто.СубконтоДт1 КАК Справочник.ОбъектыСтроительства) КАК Участок,
	               |	ВЫРАЗИТЬ(ХозрасчетныйДвиженияССубконто.СубконтоКт1 КАК Справочник.Контрагенты) КАК Владелец,
	               |	ХозрасчетныйДвиженияССубконто.Сумма КАК Доля
	               |ИЗ
	               |	РегистрБухгалтерии.Хозрасчетный.ДвиженияССубконто(
	               |			,
	               |			,
	               |			СчетДт = &Счет0803
	               |				И СчетКт = &Счет7606,
	               |			,
	               |			) КАК ХозрасчетныйДвиженияССубконто
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Период";
	Запрос.УстановитьПараметр("Счет0803", ПланыСчетов.Хозрасчетный.СтроительствоОбъектовОсновныхСредств);
	Запрос.УстановитьПараметр("Счет7606", ПланыСчетов.Хозрасчетный.РасчетыСПрочимиПокупателямиИЗаказчиками);
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Набор = РегистрыСведений.ВладельцыУчастков.СоздатьНаборЗаписей();
	Пока Выборка.Следующий() Цикл
		НоваяЗапись = Набор.Добавить();
		НоваяЗапись.Период = Выборка.Период;
		НоваяЗапись.Участок = Выборка.Участок;
		НоваяЗапись.Владелец = Выборка.Владелец;
		НоваяЗапись.Доля = Выборка.Доля;
				
	КонецЦикла;
	Набор.Записать(Истина);
	
	
КонецПроцедуры

&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере();
КонецПроцедуры
