package Model;

public abstract class Pessoa {
  // atributos(encapsulamentos)
  private String nome;
  private String cpf;

  // métodos
  // Construtor
  public Pessoa(String nome, String cpf) {
    this.nome = nome;
    this.cpf = cpf;
  }

  // getter(buscar) and setter(alterar)
  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }

  public String getCpf() {
    return cpf;
  }

  public void setCpf(String cpf) {
    this.cpf = cpf;
  }

  // metodos de exibir informações
  public void exibirInformacoes() {
    System.out.println("Nome: " + nome);
    System.out.println("CPF: " + cpf);
  }

}


