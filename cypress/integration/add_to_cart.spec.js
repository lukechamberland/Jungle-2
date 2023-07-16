describe('Add to Cart', () => {
  beforeEach(() => {
    cy.visit('/');
    // Add any setup code specific to the add to cart scenario
  });

  it('Increases the cart count when a product is added', () => {
    cy.get('.cart-count').invoke('text').as('initialCount');
  
    cy.get('.product').first().find('.add-to-cart').click();
  
    cy.get('.cart-count').invoke('text').then((initialCount) => {
      cy.get('@initialCount').then((previousCount) => {
        expect(parseInt(initialCount)).to.equal(parseInt(previousCount) + 1);
      });
    });
  });
});
