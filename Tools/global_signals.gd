extends Node

## Спрашиваем хотим мы взять объект или положить
signal interuction_type_request(callback: Callable)
signal want_carry(object: PackedScene)
signal want_object(object_name: String, callback: Callable)
