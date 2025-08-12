# json_shared_preferences

A new Flutter project.


Shared Preferences (Armazenamento interno do Aplicativo)


Armazenamento Chave -> Valor
              "config" -> "Texto" texto em formato Json

O que é um texto em formato Json?
[
    config: {
        "NomedoUsuario" : "Nome do Usuario"
        "idadedoUsuario" : 25,
        "TemaEscuro": true,
    }
]              

dart -> Linguagem de Programação do Flutter não lê JSON
     -> Converter => ( json.decode => converter Texto:Json em Map: Dart)
                  => ( json.encode => converter Map:Dart em Text:Json)


Final => é como se fosse uma constante que permite trocar o valor uma ÚNICA vez                   

Late => é uma variavel que permite trocar o valor depois

textFild -> Campo de Texto