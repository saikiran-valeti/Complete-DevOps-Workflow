java -cp "src/main/java;src/test/java" com.devops.CalculatorTest || exit 1
#!/bin/bash

echo "Compiling..."
find src -name "*.java" > sources.txt
javac @sources.txt || exit 1

echo "Running tests..."
java -cp "src/main/java;src/test/java" com.devops.CalculatorTest || exit 1

echo "Creating JAR..."
jar cfe calculator.jar com.devops.Calculator -C src/main/java .
