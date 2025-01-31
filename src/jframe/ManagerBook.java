/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package jframe;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import java.sql.ResultSet;
import javax.swing.table.TableModel;
import java.sql.SQLException;
import com.toedter.calendar.JDateChooser;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement; // Pour l'utilisation des PreparedStatements
import com.toedter.calendar.JDateChooser;
import java.text.SimpleDateFormat;
/**
 *
 * @author COMPUTER-STORE
 */
public class ManagerBook extends javax.swing.JFrame {

    /**
     * Creates new form ManagerBook
     */
    String Id, name,etab,tBac,sBac,annee;
   
    DefaultTableModel model;
        public ManagerBook() {
        initComponents();
        setBookDetailsToTable();
        
        jComboBox1.addItem("Bac General");
        jComboBox1.addItem("Bac Technique");
       jComboBox1.addItem("Bac Anglephone");
        jComboBox2.addItem("M");
        jComboBox2.addItem("F");
       
    }
        
        
    // mettre les détails de etudiants dans le tableau
  public void setBookDetailsToTable() {
    try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:4306/librairy", "root", "");
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT * FROM etudiant")) {

        DefaultTableModel model = (DefaultTableModel) tbl_bookDetail.getModel();
        model.setRowCount(0); // Vider le tableau avant de le remplir à nouveau

        while (rs.next()) {
            String id = rs.getString("etudiant_id");
            String name = rs.getString("etudiant_name");
            String sex = rs.getString("sexe");
            String date = rs.getString("date_naissance");
            String etab = rs.getString("etablissement");
            String annee = rs.getString("année");
            String tBac = rs.getString("type_bac");
            String sBac = rs.getString("serie_bac");

            Object[] rowData = {id, name,sex, date, etab, annee, tBac, sBac};
            model.addRow(rowData);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        JOptionPane.showMessageDialog(this, "Erreur lors de l'extraction des données : " + e.getMessage(), "Erreur SQL", JOptionPane.ERROR_MESSAGE);
    }
}

  
    

     // ajouter les information de letudiant dans la table
   

public boolean addBook() {
    boolean isAdded = false;

    // Récupérer les valeurs des champs de texte
    String name = txt_bookName.getText();
    String sex = (String) jComboBox2.getSelectedItem();
    String  date = txt_date.getText();
    String etab = txt_Author1.getText();
    String annee = txt_anne.getText();
    String tBac = (String) jComboBox1.getSelectedItem();
    String sBac = txt_bac2.getText();

    // Validation des champs
    if (name.isEmpty() || date.isEmpty() || etab.isEmpty() || annee.isEmpty() || tBac.isEmpty() || sBac.isEmpty()) {
        JOptionPane.showMessageDialog(this, "Tous les champs doivent être remplis.", "Erreur", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    // Validation de l'année
    if (!annee.matches("\\d{4}-\\d{4}")) {
        JOptionPane.showMessageDialog(this, "Veuillez entrer une année dans le format xxxx-yyyy.", "Format Incorrect", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    // Validation de la date
    if (!isValidDate(date)) {
        JOptionPane.showMessageDialog(this, "Veuillez entrer une date de naissance valide (format: yyyy-mm-dd).", "Format Incorrect", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    // Requête SQL pour insérer un étudiant
    String sql = "INSERT INTO etudiant (etudiant_name,sexe, date_naissance, etablissement, année, type_bac, serie_bac) VALUES (?,?, ?, ?, ?, ?, ?)";
    
    // Utiliser un bloc try-with-resources pour gérer automatiquement les connexions et déclarations
    try (Connection con = Dbconnection.getConnection();
         PreparedStatement pst = con.prepareStatement(sql)) {

        // Log de l'ouverture de la connexion
        System.out.println("Connection opened: " + con);

        // Définir les paramètres de la requête
        pst.setString(1, name);
        pst.setString(2, sex); 
        pst.setString(3, date);
        pst.setString(4, etab);
        pst.setString(5, annee);
        pst.setString(6, tBac);
        pst.setString(7, sBac);

        // Exécuter la requête et vérifier le nombre de lignes affectées
        int rowCount = pst.executeUpdate();
        if (rowCount > 0) {
            isAdded = true;
            JOptionPane.showMessageDialog(this, "Étudiant ajouté avec succès.", "Succès", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(this, "Échec de l'ajout de l'étudiant.", "Erreur", JOptionPane.ERROR_MESSAGE);
        }

    } catch (SQLException e) {
        // Log et message d'erreur SQL
        e.printStackTrace();
        JOptionPane.showMessageDialog(this, "Erreur lors de l'ajout des données : " + e.getMessage(), "Erreur SQL", JOptionPane.ERROR_MESSAGE);
    }

    // Log de la fermeture de la connexion (automatique dans le try-with-resources)
    System.out.println("Connection closed.");

    return isAdded;
}

// Méthode pour valider la date (à définir si elle n'est pas déjà présente)
private boolean isValidDate(String date) {
    try {
        java.sql.Date.valueOf(date);
        return true;
    } catch (IllegalArgumentException e) {
        return false;
    }
}
    
    // MISE a jour de etudiant
  public boolean update() {
    boolean isUpdate = false;

    String etudiantId = txt_bookId.getText();
    String name = txt_bookName.getText();
    String sex = (String) jComboBox2.getSelectedItem();
    String date = txt_date.getText();
    String etab = txt_Author1.getText();
    String annee = txt_anne.getText();
    String tBac = (String) jComboBox1.getSelectedItem();
    String sBac = txt_bac2.getText();

    if (etudiantId.isEmpty()) {
        JOptionPane.showMessageDialog(this, "L'identifiant de l'étudiant est requis.", "Erreur", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    if (!annee.matches("\\d{4}-\\d{4}")) {
        JOptionPane.showMessageDialog(this, "Veuillez entrer une année dans le format xxxx-yyyy.", "Format Incorrect", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    if (!isValidDate(date)) {
        JOptionPane.showMessageDialog(this, "Veuillez entrer une date de naissance valide (format: yyyy-mm-dd).", "Format Incorrect", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    String sql = "UPDATE etudiant SET etudiant_name = ?, sexe = ? ,date_naissance = ?, etablissement = ?, année = ?, type_bac = ?, serie_bac = ? WHERE etudiant_id = ?";
    
    try (Connection con = Dbconnection.getConnection();
         PreparedStatement pst = con.prepareStatement(sql)) {

       pst.setString(1, name);
        pst.setString(2, sex); 
        pst.setString(3, date);
        pst.setString(4, etab);
        pst.setString(5, annee);
        pst.setString(6, tBac);
        pst.setString(7, sBac);
        pst.setString(8, etudiantId);

        int rowCount = pst.executeUpdate();
        if (rowCount > 0) {
            isUpdate = true;
            JOptionPane.showMessageDialog(this, "Mise à jour réussie de l'étudiant.", "Succès", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(this, "Échec de la mise à jour de l'étudiant.", "Erreur", JOptionPane.ERROR_MESSAGE);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        JOptionPane.showMessageDialog(this, "Erreur lors de la mise à jour des données : " + e.getMessage(), "Erreur SQL", JOptionPane.ERROR_MESSAGE);
    }

    return isUpdate;
}
    //methode pour supprimer une donner du tableux
  public boolean delete() {
    boolean isDeleted = false;

    String etudiantId = txt_bookId.getText();

    if (etudiantId.isEmpty()) {
        JOptionPane.showMessageDialog(this, "L'identifiant de l'étudiant est requis.", "Erreur", JOptionPane.ERROR_MESSAGE);
        return false;
    }

    String sqlDelete = "DELETE FROM etudiant WHERE etudiant_id = ?";

    Connection con = null;
    PreparedStatement pstDelete = null;

    try {
        con = Dbconnection.getConnection();
        con.setAutoCommit(false); // Commencez une transaction

        pstDelete = con.prepareStatement(sqlDelete);
        pstDelete.setString(1, etudiantId);

        int rowsAffected = pstDelete.executeUpdate();
        if (rowsAffected > 0) {
            con.commit();
            isDeleted = true;
            JOptionPane.showMessageDialog(this, "Suppression réussie de l'étudiant.", "Succès", JOptionPane.INFORMATION_MESSAGE);
        } else {
            con.rollback();
            JOptionPane.showMessageDialog(this, "Échec de la suppression de l'étudiant.", "Erreur", JOptionPane.ERROR_MESSAGE);
        }
    } catch (SQLException e) {
        if (con != null) {
            try {
                con.rollback(); // Rollback la transaction en cas d'erreur
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
        e.printStackTrace();
        JOptionPane.showMessageDialog(this, "Erreur lors de la suppression des données : " + e.getMessage(), "Erreur SQL", JOptionPane.ERROR_MESSAGE);
    } finally {
        if (pstDelete != null) {
            try {
                pstDelete.close();
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.setAutoCommit(true); // Restaurer l'autocommit par défaut
                con.close();
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }

    return isDeleted;
}
    
    // methode pour clean la table
    
    public void clearTable(){
        DefaultTableModel model = (DefaultTableModel)tbl_bookDetail.getModel();
        model.setRowCount(0);
    }
  
    
    

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jPanel2 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        txt_bookId = new app.bolivia.swing.JCTextField();
        jLabel11 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        txt_anne = new app.bolivia.swing.JCTextField();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        jLabel17 = new javax.swing.JLabel();
        rSMaterialButtonCircle2 = new necesario.RSMaterialButtonCircle();
        rSMaterialButtonCircle3 = new necesario.RSMaterialButtonCircle();
        rSMaterialButtonCircle4 = new necesario.RSMaterialButtonCircle();
        txt_bac1 = new app.bolivia.swing.JCTextField();
        jLabel18 = new javax.swing.JLabel();
        jLabel19 = new javax.swing.JLabel();
        jLabel20 = new javax.swing.JLabel();
        txt_Author1 = new app.bolivia.swing.JCTextField();
        txt_bac2 = new app.bolivia.swing.JCTextField();
        jComboBox1 = new javax.swing.JComboBox<>();
        jLabel5 = new javax.swing.JLabel();
        jLabel21 = new javax.swing.JLabel();
        txt_date = new app.bolivia.swing.JCTextField();
        txt_bookName = new app.bolivia.swing.JCTextField();
        txt_bookName2 = new app.bolivia.swing.JCTextField();
        jComboBox2 = new javax.swing.JComboBox<>();
        jPanel3 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        tbl_bookDetail = new rojeru_san.complementos.RSTableMetro();
        jLabel3 = new javax.swing.JLabel();
        jPanel5 = new javax.swing.JPanel();
        jPanel6 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setBackground(new java.awt.Color(255, 255, 255));
        setUndecorated(true);

        jPanel1.setBackground(new java.awt.Color(102, 102, 255));
        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel2.setBackground(new java.awt.Color(255, 51, 51));

        jLabel1.setFont(new java.awt.Font("Verdana", 0, 18)); // NOI18N
        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Rewind_48px.png"))); // NOI18N
        jLabel1.setText("Back");
        jLabel1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel1MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 107, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(27, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel1.add(jPanel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 140, 40));

        txt_bookId.setBackground(new java.awt.Color(102, 102, 255));
        txt_bookId.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_bookId.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_bookId.setPlaceholder("Enter votre No ID......");
        txt_bookId.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_bookIdFocusLost(evt);
            }
        });
        txt_bookId.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_bookIdActionPerformed(evt);
            }
        });
        jPanel1.add(txt_bookId, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 100, 260, -1));

        jLabel11.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel11.setForeground(new java.awt.Color(255, 255, 255));
        jLabel11.setText("Nom/Prenom");
        jPanel1.add(jLabel11, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 140, 220, 40));

        jLabel10.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel10.setForeground(new java.awt.Color(255, 255, 255));
        jLabel10.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Contact_26px.png"))); // NOI18N
        jPanel1.add(jLabel10, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 90, 50, 60));

        jLabel12.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel12.setForeground(new java.awt.Color(255, 255, 255));
        jLabel12.setText("Sexe");
        jPanel1.add(jLabel12, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 210, 50, 40));

        jLabel13.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel13.setForeground(new java.awt.Color(255, 255, 255));
        jLabel13.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Moleskine_26px.png"))); // NOI18N
        jPanel1.add(jLabel13, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 170, 60, -1));

        txt_anne.setBackground(new java.awt.Color(102, 102, 255));
        txt_anne.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_anne.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_anne.setPlaceholder("Enter votre Annee du Bac...");
        txt_anne.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_anneFocusLost(evt);
            }
        });
        txt_anne.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_anneActionPerformed(evt);
            }
        });
        jPanel1.add(txt_anne, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 430, 260, -1));

        jLabel14.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel14.setForeground(new java.awt.Color(255, 255, 255));
        jLabel14.setText("Etablissement Frequenter");
        jPanel1.add(jLabel14, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 310, 230, 40));

        jLabel15.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel15.setForeground(new java.awt.Color(255, 255, 255));
        jLabel15.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Collaborator_Male_26px.png"))); // NOI18N
        jPanel1.add(jLabel15, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 330, 60, 50));

        jLabel16.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel16.setForeground(new java.awt.Color(255, 255, 255));
        jLabel16.setText("Date de naissance");
        jPanel1.add(jLabel16, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 240, 220, 40));

        jLabel17.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel17.setForeground(new java.awt.Color(255, 255, 255));
        jLabel17.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Unit_26px.png"))); // NOI18N
        jPanel1.add(jLabel17, new org.netbeans.lib.awtextra.AbsoluteConstraints(20, 400, 60, 60));

        rSMaterialButtonCircle2.setBackground(new java.awt.Color(255, 51, 51));
        rSMaterialButtonCircle2.setText("DELETE");
        rSMaterialButtonCircle2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rSMaterialButtonCircle2ActionPerformed(evt);
            }
        });
        jPanel1.add(rSMaterialButtonCircle2, new org.netbeans.lib.awtextra.AbsoluteConstraints(270, 620, 130, 80));

        rSMaterialButtonCircle3.setBackground(new java.awt.Color(255, 51, 51));
        rSMaterialButtonCircle3.setText("Add");
        rSMaterialButtonCircle3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rSMaterialButtonCircle3ActionPerformed(evt);
            }
        });
        jPanel1.add(rSMaterialButtonCircle3, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 620, 130, 80));

        rSMaterialButtonCircle4.setBackground(new java.awt.Color(255, 51, 51));
        rSMaterialButtonCircle4.setText("UPDATE");
        rSMaterialButtonCircle4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rSMaterialButtonCircle4ActionPerformed(evt);
            }
        });
        jPanel1.add(rSMaterialButtonCircle4, new org.netbeans.lib.awtextra.AbsoluteConstraints(140, 620, 130, 80));

        txt_bac1.setBackground(new java.awt.Color(102, 102, 255));
        txt_bac1.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_bac1.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_bac1.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_bac1FocusLost(evt);
            }
        });
        txt_bac1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_bac1ActionPerformed(evt);
            }
        });
        jPanel1.add(txt_bac1, new org.netbeans.lib.awtextra.AbsoluteConstraints(70, 462, -1, 0));

        jLabel18.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel18.setForeground(new java.awt.Color(255, 255, 255));
        jLabel18.setText("Quelle BAC avez vous ?");
        jPanel1.add(jLabel18, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 470, 240, 40));

        jLabel19.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel19.setForeground(new java.awt.Color(255, 255, 255));
        jLabel19.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Contact_26px.png"))); // NOI18N
        jPanel1.add(jLabel19, new org.netbeans.lib.awtextra.AbsoluteConstraints(30, 540, 50, 60));

        jLabel20.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel20.setForeground(new java.awt.Color(255, 255, 255));
        jLabel20.setText("No Identification");
        jPanel1.add(jLabel20, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 70, 240, 40));

        txt_Author1.setBackground(new java.awt.Color(102, 102, 255));
        txt_Author1.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_Author1.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_Author1.setPlaceholder("Enter votre Etablissement....");
        txt_Author1.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_Author1FocusLost(evt);
            }
        });
        txt_Author1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_Author1ActionPerformed(evt);
            }
        });
        jPanel1.add(txt_Author1, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 340, 260, -1));

        txt_bac2.setBackground(new java.awt.Color(102, 102, 255));
        txt_bac2.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_bac2.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_bac2.setPlaceholder("Serie du BAC......");
        txt_bac2.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_bac2FocusLost(evt);
            }
        });
        txt_bac2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_bac2ActionPerformed(evt);
            }
        });
        jPanel1.add(txt_bac2, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 560, 240, -1));

        jComboBox1.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        jComboBox1.setForeground(new java.awt.Color(102, 102, 255));
        jComboBox1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox1ActionPerformed(evt);
            }
        });
        jPanel1.add(jComboBox1, new org.netbeans.lib.awtextra.AbsoluteConstraints(200, 520, 190, -1));

        jLabel5.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        jLabel5.setText("Type de BAC.....");
        jLabel5.setToolTipText("");
        jPanel1.add(jLabel5, new org.netbeans.lib.awtextra.AbsoluteConstraints(90, 520, 120, 40));

        jLabel21.setFont(new java.awt.Font("Verdana", 0, 17)); // NOI18N
        jLabel21.setForeground(new java.awt.Color(255, 255, 255));
        jLabel21.setText("Annee ");
        jPanel1.add(jLabel21, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 390, 220, 40));

        txt_date.setBackground(new java.awt.Color(102, 102, 255));
        txt_date.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_date.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_date.setPlaceholder("Enter votre Date de Naissance....");
        txt_date.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_dateFocusLost(evt);
            }
        });
        txt_date.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_dateActionPerformed(evt);
            }
        });
        jPanel1.add(txt_date, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 270, 260, -1));

        txt_bookName.setBackground(new java.awt.Color(102, 102, 255));
        txt_bookName.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_bookName.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_bookName.setPlaceholder("Enter votre Nom/Prenom....");
        txt_bookName.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_bookNameFocusLost(evt);
            }
        });
        txt_bookName.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_bookNameActionPerformed(evt);
            }
        });
        jPanel1.add(txt_bookName, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 170, 260, -1));

        txt_bookName2.setBackground(new java.awt.Color(102, 102, 255));
        txt_bookName2.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 2, 0, new java.awt.Color(255, 255, 255)));
        txt_bookName2.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        txt_bookName2.setPlaceholder("Enter votre Nom/Prenom....");
        txt_bookName2.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                txt_bookName2FocusLost(evt);
            }
        });
        txt_bookName2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txt_bookName2ActionPerformed(evt);
            }
        });
        jPanel1.add(txt_bookName2, new org.netbeans.lib.awtextra.AbsoluteConstraints(80, 170, 260, -1));

        jComboBox2.setFont(new java.awt.Font("Tahoma", 0, 17)); // NOI18N
        jComboBox2.setForeground(new java.awt.Color(102, 102, 255));
        jComboBox2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox2ActionPerformed(evt);
            }
        });
        jPanel1.add(jComboBox2, new org.netbeans.lib.awtextra.AbsoluteConstraints(100, 220, 190, -1));

        jPanel3.setBackground(new java.awt.Color(255, 255, 255));
        jPanel3.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel4.setBackground(new java.awt.Color(102, 102, 255));

        jLabel2.setBackground(new java.awt.Color(255, 255, 255));
        jLabel2.setFont(new java.awt.Font("Verdana", 1, 36)); // NOI18N
        jLabel2.setText(" X");
        jLabel2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel2MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addGap(0, 31, Short.MAX_VALUE)
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        jPanel3.add(jPanel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(770, 0, 100, 40));

        tbl_bookDetail.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "No id", "Nom/Prenom", "Sexe", "Date de naissance", "Etablissement", "Annee", "Type de BAC", "Serie du BAC"
            }
        ));
        tbl_bookDetail.setColorBackgoundHead(new java.awt.Color(102, 102, 255));
        tbl_bookDetail.setColorBordeFilas(new java.awt.Color(102, 102, 255));
        tbl_bookDetail.setColorSelBackgound(new java.awt.Color(251, 51, 51));
        tbl_bookDetail.setFont(new java.awt.Font("Yu Gothic UI Light", 0, 25)); // NOI18N
        tbl_bookDetail.setFuenteFilas(new java.awt.Font("Yu Gothic UI Semilight", 1, 18)); // NOI18N
        tbl_bookDetail.setFuenteFilasSelect(new java.awt.Font("Yu Gothic UI", 1, 20)); // NOI18N
        tbl_bookDetail.setFuenteHead(new java.awt.Font("Yu Gothic UI Semibold", 1, 20)); // NOI18N
        tbl_bookDetail.setRowHeight(40);
        tbl_bookDetail.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tbl_bookDetailMouseClicked(evt);
            }
        });
        jScrollPane2.setViewportView(tbl_bookDetail);

        jPanel3.add(jScrollPane2, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 180, 870, 420));

        jLabel3.setBackground(new java.awt.Color(240, 240, 240));
        jLabel3.setFont(new java.awt.Font("Segoe UI", 0, 36)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 51, 51));
        jLabel3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Student_Male_100px.png"))); // NOI18N
        jLabel3.setText("Enregistrement des Etudiants");
        jPanel3.add(jLabel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(140, -10, 570, 120));

        jPanel5.setBackground(new java.awt.Color(255, 51, 51));

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 560, Short.MAX_VALUE)
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 10, Short.MAX_VALUE)
        );

        jPanel3.add(jPanel5, new org.netbeans.lib.awtextra.AbsoluteConstraints(150, 100, 560, 10));

        jPanel6.setBackground(new java.awt.Color(255, 51, 51));
        jPanel6.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel6MouseClicked(evt);
            }
        });

        jLabel4.setFont(new java.awt.Font("Verdana", 0, 18)); // NOI18N
        jLabel4.setIcon(new javax.swing.ImageIcon(getClass().getResource("/icons/icons/112.png"))); // NOI18N
        jLabel4.setText("SUIVANT");
        jLabel4.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel4MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()
                .addContainerGap(37, Short.MAX_VALUE)
                .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 139, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        jPanel3.add(jPanel6, new org.netbeans.lib.awtextra.AbsoluteConstraints(680, 660, -1, -1));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 398, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, 897, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(31, 31, 31))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, 715, Short.MAX_VALUE)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        setSize(new java.awt.Dimension(1282, 715));
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void jLabel1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel1MouseClicked
       HomePage home = new HomePage ();
       home.setVisible(true);
       dispose();
    }//GEN-LAST:event_jLabel1MouseClicked

    private void txt_bookIdFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_bookIdFocusLost
        
    }//GEN-LAST:event_txt_bookIdFocusLost

    private void txt_bookIdActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_bookIdActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bookIdActionPerformed

    private void txt_anneFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_anneFocusLost
       
    }//GEN-LAST:event_txt_anneFocusLost

    private void txt_anneActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_anneActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_anneActionPerformed

    private void rSMaterialButtonCircle2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rSMaterialButtonCircle2ActionPerformed
        if (delete ()==true ){
         
         clearTable();
         setBookDetailsToTable();
      }else {
         JOptionPane.showMessageDialog(this, "Erreur de la suppresion de Etudiant");
     }
        
    }//GEN-LAST:event_rSMaterialButtonCircle2ActionPerformed

    private void rSMaterialButtonCircle3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rSMaterialButtonCircle3ActionPerformed
     if (addBook ()==true ){
         JOptionPane.showMessageDialog(this, "Etudiant ajouter");
         clearTable();
         setBookDetailsToTable();
      }else {
         JOptionPane.showMessageDialog(this, "Erreur de l'ajout de l'Etudiant");
     }
    }//GEN-LAST:event_rSMaterialButtonCircle3ActionPerformed

    private void rSMaterialButtonCircle4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rSMaterialButtonCircle4ActionPerformed
  if (update()==true ){
        
         clearTable();
         setBookDetailsToTable();
      }else {
         JOptionPane.showMessageDialog(this, "Erreur de la mise a jour de l'Etudiant");
         
     }    }//GEN-LAST:event_rSMaterialButtonCircle4ActionPerformed

    private void jLabel2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel2MouseClicked
        System.exit(0);
    }//GEN-LAST:event_jLabel2MouseClicked

    private void txt_bac1FocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_bac1FocusLost
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bac1FocusLost

    private void txt_bac1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_bac1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bac1ActionPerformed

    private void txt_Author1FocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_Author1FocusLost
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_Author1FocusLost

    private void txt_Author1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_Author1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_Author1ActionPerformed

    private void jLabel4MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel4MouseClicked
        String[] options = {"Rechercher une école universitaire","Rechercher une ecole de formation", "Rechercher un concours", "Annuler"};
    int choice = JOptionPane.showOptionDialog(null, "Que souhaitez-vous rechercher ?", "Choix de recherche",
            JOptionPane.DEFAULT_OPTION, JOptionPane.QUESTION_MESSAGE, null, options, options[0]);

    if (choice == 0) {
        Ecole ecole = new Ecole();
        ecole.setVisible(true);
    }else if(choice ==1){
         Recherche r1 = new Recherche ();
         r1.setVisible(true);  
    }
    else if (choice == 2) {
         
    } else {
        // Annuler ou autre action par défaut
         ManagerBook m1 = new ManagerBook();
        m1.setVisible(true);
    }

    dispose(); // Fermer la fenêtre actuelle après avoir ouvert la nouvelle fenêtre

    }//GEN-LAST:event_jLabel4MouseClicked

    private void tbl_bookDetailMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tbl_bookDetailMouseClicked
       
     // Obtenir le numéro de la ligne sélectionnée
    int rowNo = tbl_bookDetail.getSelectedRow();
    TableModel model = tbl_bookDetail.getModel();

    // Vérifier si une ligne est bien sélectionnée
    if (rowNo >= 0) {
        // Utiliser une méthode pour convertir en chaîne en gérant les valeurs nulles
        txt_bookId.setText(valueToString(model.getValueAt(rowNo, 0)));
        txt_bookName.setText(valueToString(model.getValueAt(rowNo, 1)));
         // Recherche de la colonne "type_bac" et récupération de sa valeur
        String sex = null;
        for (int i = 0; i < model.getColumnCount(); i++) {
            if (model.getColumnName(i).equals("sexe")) {
                sex = valueToString(model.getValueAt(rowNo, i));
                break;
            }
        }

        // Mettre à jour le comboBox si une valeur a été trouvée pour "type_bac"
        if (sex != null) {
            jComboBox2.setSelectedItem(sex);
        }
        txt_date.setText(valueToString(model.getValueAt(rowNo, 3)));
        txt_Author1.setText(valueToString(model.getValueAt(rowNo, 4)));
        txt_anne.setText(valueToString(model.getValueAt(rowNo, 5)));

        // Recherche de la colonne "type_bac" et récupération de sa valeur
        String tBac = null;
        for (int i = 0; i < model.getColumnCount(); i++) {
            if (model.getColumnName(i).equals("type_bac")) {
                tBac = valueToString(model.getValueAt(rowNo, i));
                break;
            }
        }

        // Mettre à jour le comboBox si une valeur a été trouvée pour "type_bac"
        if (tBac != null) {
            jComboBox1.setSelectedItem(tBac);
        }

        // Mettre à jour le champ de texte pour la série du bac
        txt_bac2.setText(valueToString(model.getValueAt(rowNo, 7)));
      } else {
        // Afficher un message si aucune ligne n'est sélectionnée (facultatif)
        JOptionPane.showMessageDialog(this, "Veuillez sélectionner une ligne.", "Information", JOptionPane.INFORMATION_MESSAGE);
     }     
    }//GEN-LAST:event_tbl_bookDetailMouseClicked

    // Méthode utilitaire pour convertir un objet en chaîne de caractères en gérant les valeurs nulles
    private String valueToString(Object value) {
    return value == null ? "" : value.toString();
    }
    private void txt_bac2FocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_bac2FocusLost
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bac2FocusLost

    private void txt_bac2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_bac2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bac2ActionPerformed

    private void jComboBox1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox1ActionPerformed
       // Actions spécifiques si nécessaire
    String selectedBac = (String) jComboBox1.getSelectedItem();
    System.out.println("Sélectionné: " + selectedBac);
    }//GEN-LAST:event_jComboBox1ActionPerformed

    private void txt_dateFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_dateFocusLost
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_dateFocusLost

    private void txt_dateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_dateActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_dateActionPerformed

    private void jPanel6MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jPanel6MouseClicked
         
    }//GEN-LAST:event_jPanel6MouseClicked

    private void txt_bookNameFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_bookNameFocusLost
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bookNameFocusLost

    private void txt_bookNameActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_bookNameActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bookNameActionPerformed

    private void txt_bookName2FocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_txt_bookName2FocusLost
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bookName2FocusLost

    private void txt_bookName2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txt_bookName2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txt_bookName2ActionPerformed

    private void jComboBox2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jComboBox2ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(ManagerBook.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ManagerBook.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ManagerBook.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ManagerBook.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new ManagerBook().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> jComboBox1;
    private javax.swing.JComboBox<String> jComboBox2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel18;
    private javax.swing.JLabel jLabel19;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel21;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JScrollPane jScrollPane2;
    private necesario.RSMaterialButtonCircle rSMaterialButtonCircle2;
    private necesario.RSMaterialButtonCircle rSMaterialButtonCircle3;
    private necesario.RSMaterialButtonCircle rSMaterialButtonCircle4;
    private rojeru_san.complementos.RSTableMetro tbl_bookDetail;
    private app.bolivia.swing.JCTextField txt_Author1;
    private app.bolivia.swing.JCTextField txt_anne;
    private app.bolivia.swing.JCTextField txt_bac1;
    private app.bolivia.swing.JCTextField txt_bac2;
    private app.bolivia.swing.JCTextField txt_bookId;
    private app.bolivia.swing.JCTextField txt_bookName;
    private app.bolivia.swing.JCTextField txt_bookName2;
    private app.bolivia.swing.JCTextField txt_date;
    // End of variables declaration//GEN-END:variables

}
