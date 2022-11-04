# getcoviddata

<p> Realiza buscas em uma api de levantamento de estatisticas sobre o covid19 e realiza buscas refinadas na mesma através da sintaxe do comando jq</p>

### Exemplo de uso
source htreq.sh<br>
connect<br>
show '|select(.Continent == "Asia")|{Country,TotalDeaths}'
