// g++ new.cpp -lfmt -lspdlog
//
// https://github.com/gabime/spdlog/issues/1146#issuecomment-511189714
// https://bugs.archlinux.org/task/66579
#define SPDLOG_FMT_EXTERNAL 1
#include "spdlog/spdlog.h"
#include "spdlog/sinks/stdout_color_sinks.h"

int main() 
{

    // Console logger with color and prefix
    auto console = spdlog::stdout_color_mt("prefix001");
    console->info("Welcome to spdlog!");
    console->error("Some error message with arg{}..", 1);
    
    // Console logger with color
    spdlog::info("Welcome to spdlog!");
    spdlog::error("Some error message with arg: {}", 1);
    
    // Formatting examples
    spdlog::warn("Easy padding in numbers like {:08d}", 12);
    spdlog::critical("Support for int: {0:d};  hex: {0:x};  oct: {0:o}; bin: {0:b}", 42);
    spdlog::info("Support for floats {:03.2f}", 1.23456);
    spdlog::info("Positional args are {1} {0}..", "too", "supported");
    spdlog::info("{:<30}", "left aligned");
    
    spdlog::set_level(spdlog::level::debug); // Set global log level to debug
    spdlog::debug("This message should be displayed..");    
    
    // change log pattern
    spdlog::set_pattern("[%H:%M:%S %z] [%n] [%^---%L---%$] [thread %t] %v");
    
    // Compile time log levels
    // define SPDLOG_ACTIVE_LEVEL to desired level
    SPDLOG_TRACE("Some trace message with param {}", 42);
    SPDLOG_DEBUG("Some debug message");
}
