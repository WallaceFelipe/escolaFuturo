<?php

class Turma extends CI_Model {
    public $idturma;
    public $disciplina_codigo;
    public $professor_idprofessor;
    public $horario;
    public $alunoList;

    /*
        Construtor
    */
    public function __construct ($idturma=0) {
        // Carregando biblioteca do banco de dados
        $this->load->database();

        /*
            Recupera uma turma já existente do banco de dados
                @ se $idturma for passado como parâmetro
        */
        if ($idturma) {
            // Obtém a turma com respectivo "$idturma"
            $this->db->where('idturma', $idturma);
            
            // Obtém o primeiro resultado (index 0) da busca
            $result = $this->db->get('turmas')->result()[0];

            // Monta o objeto turma
            $this->idturma = $result->idturma;
            $this->disciplina_codigo = $result->disciplina_codigo;
            $this->professor_idprofessor = $result->professor_idprofessor;
            $this->horario = $result->horario;
            $this->alunoList = $result->alunoList;
        }

        /*
            Adicionar nova turma
                @ se $idturma não for passado como parâmetro
        */
        else {
            // Remove o atributo idturma, já que ele será
            //  automaticamente gerado pelo banco de dados.
            unset( $this->idturma );
        }
    }

    /*
        Adiciona ou atualiza a turma no banco de dados
    */
    public function save () {
        // Atualiza
        //  @ verifico se o atributo "idturma" existe neste objeto.
        //    lembrando que este atributo é apagado se criamos uma nova turma.
        if ( isset($this->idturma) ) {
             $this->db->update('turmas', $this, array('idturma' => $this->idturma));
        }
        // Salva
        else {
            $this->db->insert('turmas', $this);
        }
    }

    /*
        Deleta a turma do banco de dados
    */
    public function delete () {
        $this->db->delete('turmas', array('idturma' => $this->idturma));
    }

    /*
        Obtém uma lista de todas as turmas
    */
    public static function getTurmas () {
        // Obtém instância do CodeIgniter
        $CI =& get_instance();

        // Carregando biblioteca do banco de dados
        $CI->load->database();

        // Obtém todos os posts
        $CI->db->order_by("idturma", "cresc");
        $result = $CI->db->get('turmas')->result();

        // Monta vetor de objetos "Turma"
        $turmas  = [];

        foreach ($result as $turma) {
            $tmp    = new Turma();
            $tmp->idturma = $turma->idturma;
            $tmp->disciplina_codigo = $turma->disciplina_codigo;
            $tmp->professor_idprofessor = $turma->professor_idprofessor;
            $tmp->horario = $turma->horario;
            $tmp->alunoList = $turma->alunoList;

            $turmas[] = $tmp;
        }

        return $turmas;
    }

}