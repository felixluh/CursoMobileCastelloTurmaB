package view;

import java.util.Scanner;

import Controller.CursoController;
import Model.Aluno;
import Model.Professor;

public class CursoView {
    // atributos
    Professor Jp = new Professor("João Pereira", "123.456.789.01", 15000.00);
    CursoController cursoJava = new CursoController("Programação Java", Jp);
    private int operacao;
    private boolean continuar = true;
    Scanner sc = new Scanner(System.in);

    // metodos
    public void menu() {
        while (continuar) {
            System.out.println("==Gerenciamento Curso==: ");
            System.out.println("1.|Cadastrar Aluno");
            System.out.println("2.| Informações do Curso");
            System.out.println("3.| Lançar notas dos Alunos");
            System.out.println("4.| Status da Turma");
            System.out.println("5.| Sair");
            System.out.println("===Escolha Opção Desejada===");
            operacao = sc.nextInt();
            switch (operacao) {
                case 1:
                    Aluno aluno = cadastrarAluno();
                    cursoJava.adicionarAluno(aluno);
                    break;
                case 2:
                    cursoJava.exibirInformacoesCurso();
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 5:
                    System.out.println("Saindo...");
                    continuar = false;
                    break;
                default:
                    System.out.println("Informe uma Opção Valida:");
                    break;
            }
        }
    }

    public Aluno cadastrarAluno() {
        System.out.println("Digite o nome do aluno: ");
        String nome = sc.nextLine();
        System.out.println("Digite o CPF do Aluno: ");
        String cpf = sc.next();
        System.out.println("Informe a matricula so aluno: ");
        String matricula = sc.next();
        return new Aluno(nome, cpf, matricula);

    }
}
