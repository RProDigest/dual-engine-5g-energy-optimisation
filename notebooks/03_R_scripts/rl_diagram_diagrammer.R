# ============================================================================
# Improved RL MDP Diagram - DiagrammeR Version
# Author: Mubanga
# Requires: DiagrammeR, DiagrammeRsvg, rsvg packages
# ============================================================================

# Install packages if needed (uncomment to run):
# install.packages(c("DiagrammeR", "DiagrammeRsvg", "rsvg"))

library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

# Okabe-Ito colorblind-friendly palette
# Orange: #E69F00, Sky Blue: #56B4E9, Bluish Green: #009E73, 
# Yellow: #F0E442, Blue: #0072B2, Vermillion: #D55E00

# Create the improved diagram
fig1_rl_improved <- grViz("
digraph RL_Formal_MDP {
  // Layout settings with optimal spacing
  graph [layout = dot, rankdir = LR, fontname = 'Helvetica,Arial,sans-serif', 
         nodesep = 1.3, ranksep = 2.2, margin = 0.6, bgcolor = 'white']
  
  node [shape = box, style = 'filled, rounded', fontname = 'Helvetica-Bold', 
        penwidth = 2.5, fontsize = 13]
  edge [fontname = 'Helvetica', fontsize = 11, penwidth = 2]
  
  // --- ENVIRONMENT (Okabe-Ito Yellow) ---
  env [label = 'Environment', fillcolor = '#F0E442', color = '#D4C23C', 
       width = 2.5, height = 0.8]
  
  // --- SIGNALS ---
  // Sky Blue for state
  state_up [label = <Next State<br/><font point-size='11'>(S<sub>t+1</sub>)</font>>, 
            fillcolor = '#56B4E9', color = '#3D8FC7', width = 1.8, height = 0.7]
  
  // Bluish Green for reward  
  rew_sig  [label = <Reward Signal<br/><font point-size='11'>(R<sub>t+1</sub>)</font>>, 
            fillcolor = '#009E73', color = '#007A59', width = 1.8, height = 0.7, 
            fontcolor = 'white']
  
  // --- AGENT CLUSTER ---
  subgraph cluster_agent {
    label = 'Agent';
    fontname = 'Helvetica-Bold';
    fontsize = 14;
    color = '#D55E00';  // Vermillion
    style = dashed;
    penwidth = 2.5;
    margin = 70;
    
    // Policy (Orange)
    agent_core  [label = <Policy<br/><font point-size='11'>π(A<sub>t</sub> | S<sub>t</sub>)</font>>, 
                 fillcolor = '#E69F00', color = '#C17E00', width = 2.2, height = 0.8]
    
    // Return Calculation - FIXED: No space between γ and superscript
    return_calc [label = <Return Calculation<br/><font point-size='11'>G<sub>t</sub> = Σ γ<sup>k</sup>R<sub>t+k+1</sub></font>>, 
                 shape = ellipse, fillcolor = '#FFE6CC', color = '#D55E00', 
                 fontsize = 12, width = 2.5, height = 1.0, penwidth = 2.5]
    
    return_calc -> agent_core [arrowhead = none, style = dotted, penwidth = 2]
  }
  
  // --- CONNECTIONS ---
  // Action from policy to environment (Blue)
  agent_core -> env [label = <Action<br/><font point-size='10'>A<sub>t</sub></font>>, 
                     color = '#0072B2', penwidth = 3, fontcolor = '#0072B2']
  
  // Environment emissions
  env -> state_up [color = '#3D8FC7', penwidth = 2.5]
  env -> rew_sig  [color = '#007A59', penwidth = 2.5]
  
  // Feedback loops
  state_up -> agent_core  [label = 'Observation', color = '#3D8FC7', penwidth = 2.5, 
                           fontcolor = '#3D8FC7']
  rew_sig  -> return_calc [label = 'Feedback', color = '#007A59', penwidth = 2.5, 
                           fontcolor = '#007A59']
  
  // Vertical alignment
  {rank = same; state_up; rew_sig}
}
")

# Display in RStudio viewer
print(fig1_rl_improved)

# Export as PNG (high resolution for presentations)
fig1_rl_improved %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg_png("rl_mdp_diagram_improved.png", width = 2400, height = 1600)

# Export as PDF (vector format for publications/LaTeX)
fig1_rl_improved %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg_pdf("rl_mdp_diagram_improved.pdf", width = 10, height = 6.5)

# Export as SVG (vector format for web/slides)
fig1_rl_improved %>%
  export_svg() %>%
  writeLines("rl_mdp_diagram_improved.svg")

cat("✓ Diagram exported successfully!\n")
cat("  - PNG: rl_mdp_diagram_improved.png (2400x1600 px)\n")
cat("  - PDF: rl_mdp_diagram_improved.pdf (vector)\n")
cat("  - SVG: rl_mdp_diagram_improved.svg (vector)\n")

# ============================================================================
# Key improvements from original:
# 1. Fixed γ^k spacing (no space between gamma and superscript)
# 2. Okabe-Ito colorblind-friendly palette
# 3. Enhanced visual hierarchy with thicker lines
# 4. Better spacing and margins
# 5. Professional color scheme with consistent branding
# ============================================================================
