---
layout: post
title: Functional Interfaces
date: 2025-04-20 14:05 -0300
---
São interfaces que podem conter vários default methods, porém apenas um método abstrato. Este método poderá ser executado em forma de Lambda Expressions.

```java
@FunctionalInterface
public interface Calculator {
    int calculate(int num1, int num2);

    default int sum(int num1, int num2) {
        return num1 + num2;
    }

    default int subtract(int num1, int num2) {
        return num1 - num2;
    }

    default int multiply(int num1, int num2) {
        return num1 * num2;
    }

    default int divide(int num1, int num2) {
        return num1 / num2;
    }
}

public class Main {
    public static void main(String[] args){
        Calculator square = (num1, num2) -> num1 + (num1 * num2);
        square.calculate(4, 10); //return 44

        square.sum(10, 5); //return 15
        square.subtract(10, 5); // return 5
        square.multiply(10, 5); // return 50
        square.divide(10, 5); //return 2
    }
}
```

## Built-In Java Functional Interfaces

Algumas interfaces foram convertidas em Functional Interfaces na versão 8 do Java.

-  Runnable: Contém apenas o método run().
-  Comparable: Contém apenas o método compareTo().
-  ActionListener: Contém apenas o método actionPerformed().
-  Callable: Contém apenas o métod call().

## Tipos de Functional Interfaces

### Consumer

A interface Consumer aceita (accepts) apenas 1 valor como parâmetro e não tem retorno (void) e possui algumas variantes conforme o exemplo abaixo

```java
public class ConsumerExample {
    public static void main(String[] args) {
        Consumer<String> stringConsumer = value -> System.out.println(value);
        stringConsumer.accept("Vasco");

        IntConsumer intConsumer = value -> System.out.println(value);
        intConsumer.accept(20);

        DoubleConsumer doubleConsumer = value -> System.out.println(value);
        doubleConsumer.accept(40.5);

        LongConsumer longConsumer = value -> System.out.println(value);
        longConsumer.accept(10290382438L);

        BiConsumer<String, Long> biConsumer = (s, aLong) -> System.out.println(s + " nasceu no ano de " + aLong);
        biConsumer.accept("Vasco", 1898L);
    }
}
```

### Predicate

Representa uma valoração booleana (Boolean-valued). Ou seja, uma condição que retorna algum valor booleano. Comumente usado nas operações Stream Filter.

```java
public class PredicateExample {
    public static void main(String[] args) {
        Predicate<String> stringPredicate = value -> "Vasco".equalsIgnoreCase(value);
        stringPredicate.test("VASCO"); // return true;
        stringPredicate.test("Botafogo"); // return false;

        IntPredicate intPredicate = value -> 15 > value;
        intPredicate.test(18); // return true
        intPredicate.test(10); // return false

        DoublePredicate doublePredicate = value -> 13.4 > value;
        doublePredicate.test(13.5); //return false;
        doublePredicate.test(12.3); // return true;

        LongPredicate longPredicate = value -> 20L > value;
        longPredicate.test(23L); //return false
    }
}
```

### Function

É um tipo de Functional Interface onde
inferimos um tipo de entrada e seu tipo de saída.

```java
public class FunctionExample {
    public static void main(String[] args) {
        Function<String, Integer> lettersCount = value -> value.length();
        lettersCount.apply("Vasco"); // return 5

        BiFunction<String, Integer, Long> biFunction = (value, num) -> (long) (value.length() + num);
        biFunction.apply("Vasco", 4); //return 9

        UnaryOperator<String> unaryOperator = value -> value + " da Gama";
        unaryOperator.apply("Vasco"); // return Vasco da Gama

        BinaryOperator<String> binaryOperator = (s, s2) -> s + s2;
        binaryOperator.apply("Vasco", " da Gama"); // return Vasco da Gama
    }
}
```

### Supplier

É um tipo de Functioal Interface que não recebe dados de input, porém retorna uma saída.

```java
public class SupplierExample {
    public static void main(String[] args) {
        Supplier<String> stringSupplier = () -> "Vasco da Gama";
        System.out.println(stringSupplier.get()); // return Vasco da Gama
    }
}
```

## Pontos Importantes

-  Existe apenas 1 método abstrato em uma Functional Interface. Caso uma interface não seja decorada com um @FunctionalInterface, poderá ter vários métodos abstratos. Nesse caso, essa interface é chamada de Non-Functional Interface
-  Não existe a necessidade de decorar uma interface com @FunctionalInterface. Sua escrita é necessária apenas para checagem a nível de compilador
-  Não existem limites para métodos static e default em uma FunctionalInterface
-  Métodos sobrescritos de uma FunctionalInterface mãe não violam as regras de FunctionalInterface. A sobrescrita não conta como um método abstrato. Ex abaixo

```java
@FunctionalInterface
interface Pai {
    void fazerAlgo();
}

// Mesmo com a herança, ainda é uma functional interface
@FunctionalInterface
interface Filho extends Pai {
    // Não adiciona novo método abstrato, só sobrescreve
    @Override
    void fazerAlgo();
}

public class InheritanceExample {
    public static void main(String[] args) {
        Filho f = () -> System.out.println("Executando!");
        f.fazerAlgo();
    }
}

```