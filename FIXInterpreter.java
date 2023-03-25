import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Scanner;

public class interpreter {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the filename to interpret: ");
        String filename = scanner.nextLine();
        String fileContents = readFileContents(filename);
        String[] lines = fileContents.split("\n");
        for (String line : lines) {
            String[] tokens = line.trim().split("\\s+");
            if (tokens[0].matches("\\d+")) {
                System.out.println(tokens[0]);
            } else if (tokens[0].matches("\\+|-|\\*|/")) {
                if (tokens.length == 3 && tokens[1].matches("\\d+") && tokens[2].matches("\\d+")) {
                    int result = performOperation(Integer.parseInt(tokens[1]), tokens[0], Integer.parseInt(tokens[2]));
                    System.out.println(result);
                } else {
                    System.out.println("Invalid operation: " + line);
                }
            } else {
                System.out.println("Invalid syntax: " + line);
            }
        }
    }

    private static int performOperation(int operand1, String operator, int operand2) {
        switch (operator) {
            case "+":
                return operand1 + operand2;
            case "-":
                return operand1 - operand2;
            case "*":
                return operand1 * operand2;
            case "/":
                if (operand2 == 0) {
                    throw new ArithmeticException("Division by zero!");
                }
                return operand1 / operand2;
            default:
                throw new IllegalArgumentException("Invalid operator: " + operator);
        }
    }

    private static String readFileContents(String filename) {
        try {
            return new String(Files.readAllBytes(Paths.get(filename)), StandardCharsets.UTF_8);
        } catch (IOException e) {
            throw new RuntimeException("Error reading file: " + e.getMessage(), e);
        }
    }

}
