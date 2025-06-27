extends Node

## Спрашиваем хотим мы взять объект или положить
signal interuction_type_request(callback: Callable)
signal want_carry(object: PackedScene)
signal want_object(object_name: String, callback: Callable)
## Процент от работающих свечек от общего числа
signal ammount_of_working_candles_changed(power: float)
signal change_stability(ammount: int)
