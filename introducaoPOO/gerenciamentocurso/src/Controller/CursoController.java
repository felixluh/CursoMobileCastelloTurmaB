package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class CursoController {
    // atributos
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunosList;

    // metodos construtor
    public CursoController(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunosList = new ArrayList<>();
    }

    // adicionar alunos (crud)
    public void adicionarAluno(Aluno aluno) {
        alunosList.add(aluno);
    }

    // exibir infomações do curso
    public void exibirInformacoesCurso() {
        System.out.println("Nome Curso: " + nomeCurso);
        System.out.println("Professor: " + professor.getNome());
        System.out.println("==========================");
        int contador = 0;
        for (Aluno aluno : alunosList) {
            contador++;
            System.out.println(contador + ". " + aluno.getNome());
        }
        System.out.println("==================================");
    }

    // lançar nota

    // ver status da turma
}
