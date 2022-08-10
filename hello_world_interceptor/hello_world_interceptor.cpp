#include "hello_world_interceptor.h"

Php::Value my_hello_world(){
	return "Hello, World!";
}

Php::Value my_hello_person(Php::Parameters &parameters){
	return std::string("Hello, ") + std::string((const char*)parameters[0]) + std::string("!");
}
