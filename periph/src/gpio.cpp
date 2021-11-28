#include <stdint.h>
#include <stddef.h>
#include <assert.h>
#include "periph/gpio.hpp"

using namespace periph;

gpio::gpio(uint8_t port, uint8_t pin, enum mode mode, bool state):
    _port(port),
    _pin(pin),
    _mode(mode)
{
    assert(_port < ports);
    assert(_pin < pins);
    
    gpio::mode(_mode, state);
}

gpio::~gpio()
{
}

void gpio::set(bool state) const
{
    assert(_mode == mode::DO);
}

bool gpio::get() const
{
    assert(_mode == mode::DI && _mode == mode::DO);
    return false;
}

void gpio::toggle() const
{
    assert(_mode == mode::DO);
}

void gpio::mode(enum mode mode, bool state)
{
}
