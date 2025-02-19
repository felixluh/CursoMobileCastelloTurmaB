package Model;

public class Professor extends Pessoa {
    // atributos
    private double salário;

    // metodos
    // construtor
    public Professor(String nome, String cpf, double salário) {
        super(nome, cpf);
        this.salário = salário;
    }

    public double getSalário() {
        return salário;
    }

    public void setSalário(double salário) {
        this.salário = salário;
    }

    @Override
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Salário: " + salário);
    }
}
