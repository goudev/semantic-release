# semantic-release
<details open="open">
  <summary>Conteúdo</summary>
  <ol>
    <li>
      <a href="#sobre">Sobre</a>
    </li>
    <li>
      <a href="#usando-este-projeto">Usando este projeto</a>
    </li>
    <li>
        <a href="#instalação">Instalação</a>
    </li>
    <li><a href="#contribuindo">Contribuindo</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## Sobre

Este é um plugin para o Drone CI. Ele permite utilizar o semantic-release em seu projeto. 

## Envs
* **settings.ignore_errors**: Parametro que quando setado para 1 ignora qualquer erro de execução do comando (não falha o build). Por padrão vem desativado (não ignora erros);
* **settings.url**: A URL para o repositório git. Digitar apenas o dominio principal como por exemplo github.com; 
* **settings.username**: O usuário para acesso ao repositório;
* **settings.password**: A senha do usuário para acesso ao repositório;
* **settings.global_user_name**: Realiza a configuração do nome utilizado nos commits através do comando (git config --global user.name);
* **settings.global_user_email**: Realiza a configuração do nome utilizado nos commits através do comando (git config --global user.email);

## Drone Pipeline
```yaml
steps:

- name: semantic-release
  image: goudev/semantic-release
  settings:
  + ignore_errors: "1"
    url: 'git.meudominio.com'
    username: 'meu-usuario-git'
    password: 'minha credencial'
  + global_user_name: 'nome-do-usuario'
  + global_user_email: 'email-do-usuario'
    branch: 'master' 
  commands:
  - semantic-release --ci
```
## Executando o plugin manualmente

```shell
docker run --rm \
  -e PLUGIN_USERNAME="usuario-git" \
  -e PLUGIN_PASSWORD="senha-git" \
  -e PLUGIN_BRANCH="master" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  docker-hub.thema.inf.br/imagens/semantic-release
```
### Construído com

* ShellScript

<!-- GETTING STARTED -->
## Usando este projeto

1. Clone do respositório:
```cmd
git clone https://git.thema.inf.br/Imagens/semantic-release.git
```

### Pré-requsitos

* Docker

## Contribuindo

Este projeto adota [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), principalmente para adoção do versionamento semântico automatico. É imprescindível que seus commits sigam esse padrão. 

Para contribuir com este projeto você precisa:

1. Faça o checkout do projeto;
2. Crie uma branch com a funcionalidade que deseja (`git checkout -b feature/funcionalidade`);
3. Realize o commit de suas alterações (`git commit -m 'feat: Adicionado minha funcionalidade`);
4. Realize o push do seu branch (`git push origin feature/funcionalidade`);
5. Abra um Pull request para merge do seu branch.