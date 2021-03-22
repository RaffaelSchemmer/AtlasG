The AtlasG environment automates the various processes related to the design flow for some of NoCs proposed by the GAPH Group and eventually by other groups with which we collaborate. Currently, the design flow is composed by the following stages: NoC generation, traffic generation, simulation, performance and power evaluation. In the NoC generation, the NoC parameters (for example, channel bandwidth, buffer depth, number of virtual channels, flow control strategies) are configured. In the traffic generation, the traffic sceneries are generated to characterize the applications which execute on the NoC. In the simulation, the traffic data are injected in the NoC, occurring in this step the effective communication among the cores. In the performance evaluation, it is possible to generate graphics, tables, maps and reports to help in the analysis of obtained results.

Instalação do ambiente Atlas e das ferramentas relacionadas:

Ubuntu 10.04 LTS x64-64.
Java: apt-get install openjdk-6-jdk.
Gnuplot: apt-get install gnuplot.
Modelsim 10.0c:
  Atualize o pacote ia32-libs: apt-get install ia32-libs.
  Instale todos os pacote disponíveis na instalação.
Descompacte o pacote gcc-4.3.3-linux_x86_64.rar na raiz do modelsim instalado (Referente ao SystemC).

Configuração do ambiente:

Copie para o bashrc (/home/user/.bashrc) as seguintes variáveis de ambiente:
  export JAVA_HOME=/usr/bin.
  export GNUPLOT_HOME=/usr/bin.
  export ATLAS_HOME=path to atlas folder.
  export MODELSIM_HOME=path to modelsim folder.
  export PATH=$MODELSIM_HOME:$PATH.

Atualize o terminal com o comando: source. Bashrc.

Compilação e Execução:

Acesse o diretório da atlas, compile o projeto através do comando: make atlas
Para acessar a atlas digite no diretório raiz da mesma: java Atlas
Apenas na primeira execução, selecione um navegador padrão (Usado na avaliação de tráfego). 
Recomenda-se que o Firefox seja informado, navegador presente no diretório /usr/bin/.

Simulando um projeto (Atlas com tráfego sintético):

A partir da interface principal, no menu projects, selecione new project. Defina um diretório, um nome e um tipo de rede (No caso HERMES-G para este exemplo).

Clique no botão NoC Generation, defina os parâmetros que preferir para NoC. Uma vez feito, clique em generate para gerar a rede.

Selecione o botão traffic generation, em manage scenery, clique em new scenery para gerar um tráfego sintético, ou open CDCG model para um tráfego de aplicação (É necessário usar o cafes para obter um tráfego de aplicação). Para um tráfego sintético, defina um nome para o tráfego, e clicando nas caixas pretas referentes aos transmissores, defina valores para o tráfego. Ainda, é possível no menu configuration/standard configuration definir um valor para o tráfego, onde a ferramenta assume que todos os IPs irão transmitir aquele tráfego. Por fim, clique em generate para gerar o tráfego. Para o processo de geração de tráfego de aplicações, apenas é necessário carregar o arquivo output.model, e selecionar o botão generate para gerar o tráfego.

Use o botão simulation para simular a rede. Selecione qual dos tráfegos gerados deverá ser usado durante a simulação.

Clique em performance evaluation para avaliar um tráfego simulado. Informe qual tráfego simulado será avaliado, e utilize as ferramentas de avaliação externa para visualização dos dados referentes a performance dos tráfegos.
